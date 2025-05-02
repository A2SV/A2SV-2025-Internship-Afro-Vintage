// lib/features/reseller/orders/data/datasources/order_remote_data_source.dart
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/data/models/reseller_order_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderRemoteDataSource {
  Future<OrderHistoryModel> getOrderHistory();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final SharedPreferences sharedPreferences;

  OrderRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  }) : baseUrl = "https://2kps99nm-8081.uks1.devtunnels.ms";

  Map<String, String> get _headers {
    final token = sharedPreferences.getString('auth_token') ?? '';
    print('Using token: ${token.isNotEmpty ? 'Token exists' : 'No token found'}');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<OrderHistoryModel> getOrderHistory() async {
    try {
      print('Getting order history');
      print('Request URL: $baseUrl/orders/reseller/history');
      print('Headers: $_headers');

      final response = await client.get(
        Uri.parse('$baseUrl/orders/reseller/history'),
        headers: _headers,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('Request timed out');
          throw TimeoutException('Request timed out');
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('Decoded JSON: $jsonResponse');
        
        if (jsonResponse['success'] == true) {
          return OrderHistoryModel.fromJson(jsonResponse['data']);
        } else {
          print('API returned success: false');
          print('Error message: ${jsonResponse['message']}');
          throw ServerException();
        }
      } else if (response.statusCode == 401) {
        print('Unauthorized access');
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        print('Endpoint not found');
        throw ServerException();
      } else {
        print('Unexpected status code: ${response.statusCode}');
        throw ServerException();
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e');
      throw ServerException();
    } on FormatException catch (e) {
      print('JSON parsing error: $e');
      throw ServerException();
    } on http.ClientException catch (e) {
      print('Network error: $e');
      throw ServerException();
    } catch (e) {
      print('Unexpected error: $e');
      throw ServerException();
    }
  }
}