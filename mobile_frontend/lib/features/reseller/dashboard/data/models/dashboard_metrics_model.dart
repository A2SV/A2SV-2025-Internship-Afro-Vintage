import 'package:mobile_frontend/core/error/exception.dart';

import '../../domain/entities/dashboard_metrics.dart';

class DashboardMetricsModel extends DashboardMetrics {
  DashboardMetricsModel({
    required int totalBoughtBundles,
    required int totalItemsSold,
    required double rating,
    required double bestSelling,
    required List<BoughtBundleModel> boughtBundles,
  }) : super(
          totalBoughtBundles: totalBoughtBundles,
          totalItemsSold: totalItemsSold,
          rating: rating,
          bestSelling: bestSelling,
          boughtBundles: boughtBundles,
        );

  factory DashboardMetricsModel.fromJson(Map<String, dynamic> json) {
    try {
      print('Parsing metrics JSON: $json'); // Debug print

      return DashboardMetricsModel(
        totalBoughtBundles: json['totalBoughtBundles'] as int? ?? 0,
        totalItemsSold: json['totalItemsSold'] as int? ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        bestSelling: (json['bestSelling'] as num?)?.toDouble() ?? 0.0,
        boughtBundles: (json['boughtBundles'] as List?)
                ?.map((bundle) => BoughtBundleModel.fromJson(bundle))
                .toList() ??
            [],
      );
    } catch (e) {
      print('Error parsing metrics JSON: $e');
      throw ServerException();
    }
  }
}

class BoughtBundleModel extends BoughtBundle {
  BoughtBundleModel({
    required String id,
    required String supplierId,
    required String title,
    required String description,
    required String sampleImage,
    required int quantity,
    required String grade,
    required String sortingLevel,
    required Map<String, int> estimatedBreakdown,
    required String type,
    required double price,
    required String status,
    required DateTime createdAt,
    required int declaredRating,
    required int remainingItemCount,
  }) : super(
          id: id,
          supplierId: supplierId,
          title: title,
          description: description,
          sampleImage: sampleImage,
          quantity: quantity,
          grade: grade,
          sortingLevel: sortingLevel,
          estimatedBreakdown: estimatedBreakdown,
          type: type,
          price: price,
          status: status,
          createdAt: createdAt,
          declaredRating: declaredRating,
          remainingItemCount: remainingItemCount,
        );

  factory BoughtBundleModel.fromJson(Map<String, dynamic> json) {
    return BoughtBundleModel(
      id: json['ID'] as String,
      supplierId: json['SupplierID'] as String,
      title: json['Title'] as String,
      description: json['Description'] as String,
      sampleImage: json['SampleImage'] as String,
      quantity: json['Quantity'] as int,
      grade: json['Grade'] as String,
      sortingLevel: json['SortingLevel'] as String,
      estimatedBreakdown:
          Map<String, int>.from(json['EstimatedBreakdown'] as Map),
      type: json['Type'] as String,
      price: (json['Price'] as num).toDouble(),
      status: json['Status'] as String,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
      declaredRating: json['DeclaredRating'] as int,
      remainingItemCount: json['RemainingItemCount'] as int,
    );
  }
}
