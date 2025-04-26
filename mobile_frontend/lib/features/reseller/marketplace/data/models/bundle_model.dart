import '../../domain/entities/bundle.dart';

class BundleModel extends Bundle {
  BundleModel({
    required String id,
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
    required String supplierId,
    required double supplierRating,
    required String sizeRange,
    required List<String> clothingTypes,
  }) : super(
          id: id,
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
          supplierId: supplierId,
          supplierRating: supplierRating,
          sizeRange: sizeRange,
          clothingTypes: clothingTypes,
        );
  factory BundleModel.fromJson(Map<String, dynamic> json) {
  // Handle purchase response format
  if (json.containsKey('order') && json.containsKey('payment') && json.containsKey('warehouseItem')) {
    final warehouseItem = json['warehouseItem'];
    return BundleModel(
      id: warehouseItem['ID'] ?? '',
      title: warehouseItem['SampleImage'] ?? '', // Using sample image as title for now
      description: '',
      sampleImage: warehouseItem['SampleImage'] ?? '',
      quantity: warehouseItem['Quantity'] ?? 0,
      grade: warehouseItem['Grade'] ?? '',
      sortingLevel: warehouseItem['SortingLevel'] ?? '',
      estimatedBreakdown: {},
      type: warehouseItem['Type'] ?? '',
      price: 0.0, // Price is not included in warehouse item
      status: warehouseItem['Status'] ?? '',
      createdAt: DateTime.parse(warehouseItem['CreatedAt'] ?? DateTime.now().toIso8601String()),
      declaredRating: warehouseItem['DeclaredRating'] ?? 0,
      remainingItemCount: warehouseItem['RemainingItemCount'] ?? 0,
      supplierId: warehouseItem['ResellerID'] ?? '',
      supplierRating: 0.0,
      sizeRange: '',
      clothingTypes: [],
    );
  }

  // Handle regular bundle format
  return BundleModel(
    id: json['ID'] as String,
    title: json['Title'] as String,
    description: json['Description'] as String,
    sampleImage: json['SampleImage'] as String,
    quantity: json['Quantity'] as int,
    grade: json['Grade'] as String,
    sortingLevel: json['SortingLevel'] as String,
    estimatedBreakdown: json['EstimatedBreakdown'] != null 
        ? Map<String, int>.from(json['EstimatedBreakdown'])
        : {},
    type: json['Type'] as String,
    price: (json['Price'] as num).toDouble(),
    status: json['Status'] as String,
    createdAt: DateTime.parse(json['CreatedAt'] as String),
    declaredRating: json['DeclaredRating'] as int,
    remainingItemCount: json['RemainingItemCount'] as int,
    supplierId: json['SupplierID'] as String,
    supplierRating: 0.0,
    sizeRange: json['size_range'] as String? ?? '',
    clothingTypes: [],
  );
}
}