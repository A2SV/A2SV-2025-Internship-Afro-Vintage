import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/orders/data/models/order_model.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderDataSource {
  Future<List<OrderEntity>> getOrders();
}

class OrderDataSourceImpl implements OrderDataSource {
  final String _baseUrl = "https://2kps99nm-8080.uks1.devtunnels.ms";

  final http.Client client;

  OrderDataSourceImpl({required this.client});

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      final response = await client.get(
        Uri.parse("$_baseUrl/orders/history"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("DataSource: Response received: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Check if 'data' contains 'orders'
        if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data']['orders'] is List) {
          final ordersList = responseData['data']['orders'] as List;

          // Map each order to OrderModel
          return ordersList.map((orderData) {
            final orderJson = orderData['order'];
            final productsJson = orderData['products'] ?? [];
            final resellerUsername = orderData['resellerUsername'] ?? '';

            if (orderJson != null) {
              return OrderModel.fromJson({
                ...orderJson,
                'products': productsJson,
                'resellerUsername': resellerUsername,
              });
            } else {
              print("Warning: Missing 'order' key in orderData: $orderData");
              throw Exception("Invalid order data format");
            }
          }).toList();
        } else if (responseData is Map<String, dynamic> &&
            responseData['data'] is Map<String, dynamic> &&
            (responseData['data']['orders'] as List).isEmpty) {
          // Handle case where 'orders' is an empty list
          print("No orders found.");
          return [];
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        print(
            "Failed to fetch Orders: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to fetch Orders');
      }
    } catch (e) {
      print("Error in getOrders: $e");
      rethrow;
    }
  }
}
