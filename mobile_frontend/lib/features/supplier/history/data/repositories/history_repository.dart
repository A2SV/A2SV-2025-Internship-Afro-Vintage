import '../../../../../../core/network/api_service.dart';

class HistoryRepository {
  final ApiService api;
  HistoryRepository({required this.api});

  Future<List<Map<String, dynamic>>> fetchSupplierOrderHistory() async {
    final response = await ApiService.get('/orders/supplier/history');
    if (response['success'] == true && response['data'] != null) {
      final orders = response['data']['orders'] as List<dynamic>?;
      return orders?.cast<Map<String, dynamic>>() ?? [];
    } else {
      throw Exception(response['message'] ?? 'Failed to fetch order history');
    }
  }
} 