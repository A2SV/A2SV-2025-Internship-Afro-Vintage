import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/core/error/exception.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardMetricsModel> getResellerMetrics();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl;

  DashboardRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
    this.baseUrl = "https://2kps99nm-8081.uks1.devtunnels.ms",
  });

  Map<String, String> get _headers {
    final token = sharedPreferences.getString('auth_token') ?? '';
    print('Using token: $token'); // Debug print
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<DashboardMetricsModel> getResellerMetrics() async {
    try {
      print('Fetching reseller metrics from: $baseUrl/reseller/metrics');
      final response = await client.get(
        Uri.parse('$baseUrl/reseller/metrics'),
        headers: _headers,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);

        // Check if the response has a data field (common API response structure)
        final metricsData = decodedJson['data'] ?? decodedJson;

        return DashboardMetricsModel.fromJson(metricsData);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('Error fetching metrics: $e');
      throw ServerException();
    }
  }
}
