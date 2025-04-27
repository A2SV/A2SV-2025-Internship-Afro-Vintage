import 'dart:io';
import 'package:mobile_frontend/core/network/api_service.dart';
import '../../../../marketplace/data/models/bundle_model.dart';
import '../bundle_request_model.dart';

class BundleRepository {
  final ApiService api;

  BundleRepository({required this.api});

  Future<String> createBundle({
    required String name,
    required int itemCount,
    required String type,
    required double price,
    required String description,
    required List<File> imageFiles,
    List<String>? imageUrls,
    required String grade,
    required int declaredRating,
  }) async {
    final urls = (imageUrls != null && imageUrls.isNotEmpty)
        ? imageUrls
        : await Future.wait(imageFiles.map((file) => api.uploadImage(file)));

    final response = await api.post('/bundles', body: {
      'title': name,
      'sample_image': urls.isNotEmpty ? urls.first : '',
      'number_of_items': itemCount,
      'grade': grade,
      'price': price,
      'description': description,
      'type': type,
      'declared_rating': declaredRating,
    });
    return response['id'] ?? response['data']?['id'] ?? '';
  }

  Future<Map<String, dynamic>> createBundleFromModel(BundleRequestModel bundle) async {
    final response = await api.post('/bundles', body: bundle.toJson());
    return response;
  }

  Future<Map<String, dynamic>> editBundle({
    required String id,
    required BundleRequestModel bundle,
  }) async {
    try {
      final response = await ApiService.put('/bundles/$id', body: bundle.toJson());
      
      if (response['success'] == false) {
        throw Exception(response['message'] ?? 'Failed to update bundle');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to update bundle: $e');
    }
  }

  Future<BundleModel> fetchBundleById(String id) async {
    try {
      print('[DEBUG] Fetching bundle with ID: $id');
      print('[DEBUG] Making GET request to /bundles/$id');
      final response = await ApiService.get('/bundles/$id');
      print('[DEBUG] Raw API response: $response');

      if (response['success'] == false) {
        throw Exception(response['message'] ?? 'Failed to fetch bundle');
      }

      // Get the bundle data from the response
      final bundleData = response['data'];
      if (bundleData == null) {
        throw Exception('Bundle data not found in response');
      }

      print('[DEBUG] Bundle data from API:');
      print('[DEBUG] ID: ${bundleData['id']}');
      print('[DEBUG] Title: ${bundleData['title']}');
      print('[DEBUG] Sample Image: ${bundleData['sample_image']}');
      print('[DEBUG] Quantity: ${bundleData['quantity']}');
      print('[DEBUG] Grade: ${bundleData['grade']}');
      print('[DEBUG] Description: ${bundleData['description']}');
      print('[DEBUG] Size Range: ${bundleData['size_range']}');
      print('[DEBUG] Type: ${bundleData['type']}');
      print('[DEBUG] Price: ${bundleData['price']}');
      print('[DEBUG] Status: ${bundleData['status']}');
      print('[DEBUG] Declared Rating: ${bundleData['declared_rating']}');

      // Process the bundle data to ensure all fields are present
      final processedData = {
        'id': bundleData['id'] ?? '',
        'title': bundleData['title'] ?? '',
        'description': bundleData['description'] ?? '',
        'grade': bundleData['grade'] ?? 'A',
        'price': bundleData['price'] ?? 0.0,
        'type': bundleData['type'] ?? 'sorted',
        'status': bundleData['status'] ?? 'available',
        'sample_image': bundleData['sample_image'] ?? '',
        'quantity': bundleData['quantity'] ?? 0,
        'declared_rating': bundleData['declared_rating'] ?? 0,
        'size_range': bundleData['size_range'] ?? '',
        'sorting_level': bundleData['sorting_level'] ?? 'sorted',
        'estimated_breakdown': bundleData['estimated_breakdown'],
      };

      print('[DEBUG] Processed bundle data: $processedData');
      return BundleModel.fromJson(processedData);
    } catch (e) {
      print('[DEBUG] Error fetching bundle: $e');
      throw Exception('Failed to fetch bundle: $e');
    }
  }
}