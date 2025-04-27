import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel(
    super.id,
    super.title,
    super.price,
    super.imageURL,
    super.grade,
    super.createdAt, {
    required super.listing_id,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      json['id']?.toString() ?? '', // Default to an empty string if null
      json['title'] ?? 'Unknown', // Default to 'Unknown' if null
      json['price'] != null
          ? double.tryParse(json['price'].toString()) ??
              0.0 // Parse price safely
          : 0.0,
      json['image_url']?.toString() ?? '', // Default to an empty string if null
      json['grade']?.toString() ?? 'Unknown', // Default to 'Unknown' if null
      json['created_at'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(), // Default to current time if null or invalid
      listing_id: json['listing_id']?.toString() ??
          '', // Default to an empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageURL': imageURL,
      'grade': grade,
      'createdAt': createdAt?.toIso8601String() ?? '',
      'listing_id': listing_id,
    };
  }
}
