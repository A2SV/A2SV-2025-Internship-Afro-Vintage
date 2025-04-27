import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/checkout/data/models/checkout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CheckoutDataSource {
  Future<CheckoutModel> checkout();
}

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final String _baseUrl = "https://2kps99nm-8081.uks1.devtunnels.ms";
  final http.Client client;

  CheckoutDataSourceImpl({required this.client});

  @override
  Future<CheckoutModel> checkout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");

      final response = await client.post(
        Uri.parse("$_baseUrl/api/checkout"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("DataSource: Response received: $responseData");
        return CheckoutModel.fromJson(responseData);
      } else {
        print(
            "Failed to fetch checkout data: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to fetch checkout data');
      }
    } catch (e) {
      print("Error in checkout: $e");
      rethrow;
    }
  }
}
