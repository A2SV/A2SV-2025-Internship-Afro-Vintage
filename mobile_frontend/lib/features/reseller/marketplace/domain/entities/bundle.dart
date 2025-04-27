class Bundle {
  final String id;
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
  final String supplierId;
  final double supplierRating;
  final String sizeRange;
  final List<String> clothingTypes;

  Bundle({
    required this.id,
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
    required this.supplierId,
    required this.supplierRating,
    required this.sizeRange,
    required this.clothingTypes,
  });
}