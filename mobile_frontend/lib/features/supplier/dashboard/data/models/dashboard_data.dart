import '../../../marketplace/data/models/bundle_model.dart';

class DashboardData {
  final int totalSales;
  final List<BundleModel> activeBundles;
  final int totalBundlesListed;
  final int activeCount;
  final int soldCount;
  final int rating;
  final int bestSelling;

  DashboardData({
    required this.totalSales,
    required this.activeBundles,
    required this.totalBundlesListed,
    required this.activeCount,
    required this.soldCount,
    required this.rating,
    required this.bestSelling,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    List<BundleModel> parseActiveBundles(dynamic value) {
      if (value is List) {
        return value.map((e) => BundleModel.fromJson(e)).toList();
      }
      return [];
    }

    return DashboardData(
      totalSales: parseInt(json['totalSales']),
      activeBundles: parseActiveBundles(json['activeBundles']),
      totalBundlesListed: parseInt(json['performanceMetrics']?['totalBundlesListed']),
      activeCount: parseInt(json['performanceMetrics']?['activeCount']),
      soldCount: parseInt(json['performanceMetrics']?['soldCount']),
      rating: parseInt(json['rating']),
      bestSelling: parseInt(json['bestSelling']),
    );
  }
}