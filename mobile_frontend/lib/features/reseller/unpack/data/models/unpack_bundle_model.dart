// lib/features/reseller/unpack/data/models/unpack_bundle_model.dart
import 'dart:convert';
import 'dart:io';
import '../../domain/entities/unpack_bundle.dart';
import 'package:image_picker/image_picker.dart';

// lib/features/reseller/unpack/data/models/unpack_bundle_model.dart
class UnpackBundleModel extends UnpackBundle {
  UnpackBundleModel({
    required String clothName,
    required String category,
    required String status,
    required double price,
    required String description,
    required XFile imageFile,
    required String bundleId,
    required String size,
    required int rating,
  }) : super(
          clothName: clothName,
          category: category,
          status: status,
          price: price,
          description: description,
          imageFile: imageFile,
          bundleId: bundleId,
          size: size,
          rating: rating,
        );

  Future<Map<String, dynamic>> toJson() async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    
    return {
      'title': clothName,  // Changed from clothName to title
      'description': description,
      'size': size,
      'type': category,  // Changed from category to type
      'grade': status,   // Changed from status to grade
      'price': price,
      'image_url': base64Image,  // Changed from image_url to sample_image
      'bundle_id': bundleId,  // Changed from bundleId to bundle_id
      'rating': rating,
    };
  }
}