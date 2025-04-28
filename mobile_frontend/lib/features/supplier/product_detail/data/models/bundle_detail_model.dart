import '../../domain/entities/bundle_detail.dart';

class BundleDetailModel extends BundleDetail {
  BundleDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.sampleImage,
    required super.quantity,
    required super.grade,
    required super.sortingLevel,
    required super.type,
    required super.price,
    required super.status,
    required super.declaredRating,
    required super.sizeRange,
    super.createdAt,
  });

  factory BundleDetailModel.fromJson(Map<String, dynamic> json) {
    return BundleDetailModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      sampleImage: "assets/images/cloth_3.png", // Always use local asset
      quantity: json['quantity'] ?? 0,
      grade: json['grade'] ?? 'A',
      sortingLevel: json['sorting_level'] ?? 'sorted',
      type: json['type'] ?? 'sorted',
      price: json['price']?.toDouble() ?? 0.0,
      status: json['status'] ?? 'available',
      declaredRating: json['declared_rating'] ?? 0,
      sizeRange: json['size_range'] ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sample_image': sampleImage,
      'quantity': quantity,
      'grade': grade,
      'sorting_level': sortingLevel,
      'type': type,
      'price': price,
      'status': status,
      'declared_rating': declaredRating,
      'size_range': sizeRange,
      'created_at': createdAt?.toIso8601String(),
    };
  }
} 