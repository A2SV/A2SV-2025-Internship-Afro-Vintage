import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
    super.grade, {
    required super.id,
    required super.title,
    required super.price,
    required super.photo,
    required super.size,
    required super.status,
    required super.seller_id,
    required super.rating,
    required super.description,
    required super.type,
    required super.bundle_id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['grade'],
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'Unknown',
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      photo: json['photo']?.toString() ?? '',
      size: json['size'] ?? 'Unknown',
      status: json['status'] ?? 'Unavailable',
      seller_id: json['seller_id']?.toString() ?? '',
      rating: json['rating'] != null
          ? (double.tryParse(json['rating'].toString()) ?? 0.0) / 20
          : 0.0, // Divide rating by 20
      description: json['description'] ?? 'No description available',
      type: json['type'] ?? 'Unknown',
      bundle_id: json['bundle_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "photo": photo,
      "grade": grade,
      "size": size,
      "status": status,
      "seller_id": seller_id,
      "rating": rating,
      "description": description,
      "type": type,
      "bundle_id": bundle_id,
    };
  }
}
