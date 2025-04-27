// lib/features/reseller/unpack/data/models/unpack_item_model.dart
import '../../domain/entities/unpack_bundle.dart';

class UnpackBundleModel extends UnpackBundle {
  UnpackBundleModel({
    required String clothName,
    required String category,
    required String status,
    required double price,
    required String description,
    required String imageUrl,
    required String bundleId,
  }) : super(
          clothName: clothName,
          category: category,
          status: status,
          price: price,
          description: description,
          imageUrl: imageUrl,
          bundleId: bundleId,
        );

  factory UnpackBundleModel.fromJson(Map<String, dynamic> json) {
    return UnpackBundleModel(
      clothName: json['clothName'],
      category: json['category'],
      status: json['status'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      bundleId: json['bundleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clothName': clothName,
      'category': category,
      'status': status,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'bundleId': bundleId,
    };
  }
}