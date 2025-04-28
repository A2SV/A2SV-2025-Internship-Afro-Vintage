import '../../../../../../core/network/api_service.dart';
import '../models/bundle_detail_model.dart';

class BundleDetailRepository {
  final ApiService api;

  BundleDetailRepository({required this.api});

  Future<BundleDetailModel> fetchBundleDetail(String bundleId) async {
    try {
      final response = await ApiService.get('/bundles/$bundleId');
      if (response['success'] == false) {
        throw Exception(response['message'] ?? 'Failed to fetch bundle detail');
      }
      return BundleDetailModel.fromJson(response['data'] ?? response);
    } catch (e) {
      throw Exception('Failed to fetch bundle detail: $e');
    }
  }

  Future<String> deleteBundle(String bundleId) async {
    try {
      final response = await ApiService.delete('/bundles/$bundleId');
      if (response['success'] == true) {
        return response['message'] ?? 'Bundle successfully deactivated';
      } else {
        throw Exception(response['message'] ?? 'Failed to delete bundle');
      }
    } catch (e) {
      throw Exception('Failed to delete bundle: $e');
    }
  }
} 