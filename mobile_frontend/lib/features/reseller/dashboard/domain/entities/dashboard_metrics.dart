class DashboardMetrics {
  final int totalBoughtBundles;
  final int totalItemsSold;
  final double rating;
  final double bestSelling;
  final List<BoughtBundle> boughtBundles;

  DashboardMetrics({
    required this.totalBoughtBundles,
    required this.totalItemsSold,
    required this.rating,
    required this.bestSelling,
    required this.boughtBundles,
  });
}

class BoughtBundle {
  final String id;
  final String supplierId;
  final String title;
  final String description;
  final String sampleImage;
  final int quantity;
  final String grade;
  final String sortingLevel;
  final Map<String, int> estimatedBreakdown;
  final String type;
  final double price;
  final String status;
  final DateTime createdAt;
  final int declaredRating;
  final int remainingItemCount;

  BoughtBundle({
    required this.id,
    required this.supplierId,
    required this.title,
    required this.description,
    required this.sampleImage,
    required this.quantity,
    required this.grade,
    required this.sortingLevel,
    required this.estimatedBreakdown,
    required this.type,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.declaredRating,
    required this.remainingItemCount,
  });
}
