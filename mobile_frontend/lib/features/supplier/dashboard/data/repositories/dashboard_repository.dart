import '../../../../../core/network/api_service.dart';
import '../models/dashboard_data.dart';

class DashboardRepository {
  final ApiService api;

  DashboardRepository({required this.api});

  Future<DashboardData> fetchDashboardData() async {
    try {
      final response = await ApiService.get(
          'https://2kps99nm-8081.uks1.devtunnels.ms/supplier/dashboard');
      if (response['success'] == false) {
        throw Exception(
            response['message'] ?? 'Failed to fetch dashboard data');
      }
      return DashboardData.fromJson(response['data'] ?? response);
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }
}
