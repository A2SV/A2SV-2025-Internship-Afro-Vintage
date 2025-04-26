import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/marketplace/data/models/product_model.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  final String _baseUrl = "https://2kps99nm-8080.uks1.devtunnels.ms";

  final http.Client client;

  ProductDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      final response = await client.get(
        Uri.parse("$_baseUrl/products"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("DataSource: Response received: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Handle case where response is a list of products
        if (responseData is List) {
          return responseData
              .map((product) => ProductModel.fromJson(product))
              .toList();
        }

        // Handle case where response is a map with an empty 'products' key
        if (responseData is Map<String, dynamic> &&
            responseData['products'] is List) {
          final productsList = responseData['products'] as List;

          // Return an empty list if 'products' is empty
          if (productsList.isEmpty) {
            print("No products available.");
            return [];
          }

          // Map each product to ProductModel
          return productsList
              .map((product) => ProductModel.fromJson(product))
              .toList();
        }

        throw Exception('Unexpected response format');
      } else {
        print(
            "Failed to fetch products: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print("Error in getProducts: $e");
      rethrow;
    }
  }
}
