// lib/features/reseller/unpack/domain/entities/unpack_bundle.dart
import 'package:image_picker/image_picker.dart';

class UnpackBundle {
  final String clothName;
  final String category;
  final String status;
  final double price;
  final String description;
  final XFile imageFile;  // This should be File or XFile
  final String bundleId;
  final String size;
  final int rating;

  UnpackBundle({
    required this.clothName,
    required this.category,
    required this.status,
    required this.price,
    required this.description,
    required this.imageFile,
    required this.bundleId,
    required this.size,
    required this.rating,
  });
}