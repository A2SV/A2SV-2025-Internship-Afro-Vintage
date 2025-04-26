// lib/features/reseller/unpack/data/datasources/image_utils.dart
import 'dart:convert';
import 'dart:io';

Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return 'data:image/${imageFile.path.split('.').last};base64,$base64Image';
}