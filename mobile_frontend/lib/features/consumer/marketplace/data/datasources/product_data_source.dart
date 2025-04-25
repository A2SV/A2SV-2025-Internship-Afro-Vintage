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
      // print("DataSource: Starting getProducts");
      final prefs = await SharedPreferences.getInstance();
      // print("DataSource: SharedPreferences initialized");
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      final response = await client.get(
        Uri.parse("$_baseUrl/products"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("DataSource: Response  received: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        for (var product in responseData) {
          // print("Product image_url: ${product['image_url']}");
        }
        return (responseData as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
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
