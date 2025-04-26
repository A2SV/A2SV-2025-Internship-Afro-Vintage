import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';
import 'package:mobile_frontend/core/error/exception.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderDetails(String orderId);
  Future<OrderModel> cancelOrder(String orderId);
  Future<List<OrderModel>> getOrdersByStatus(String status);
  Future<OrderModel> updateShippingAddress(String orderId, String newAddress);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final String _baseUrl;

  OrderRemoteDataSourceImpl({
    required this.client,
  }) : _baseUrl = "https://a2sv-2025-internship-afro-vintage.onrender.com/api";

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await client.get(
      Uri.parse('$_baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> getOrderDetails(String orderId) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/orders/$orderId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return OrderModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> cancelOrder(String orderId) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/orders/$orderId/cancel'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return OrderModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderModel>> getOrdersByStatus(String status) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/orders?status=$status'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> updateShippingAddress(String orderId, String newAddress) async {
    final response = await client.patch(
      Uri.parse('$_baseUrl/orders/$orderId/shipping-address'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'shipping_address': newAddress}),
    );

    if (response.statusCode == 200) {
      return OrderModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}