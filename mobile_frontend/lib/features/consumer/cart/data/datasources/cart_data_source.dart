import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/cart/data/models/cart_model.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartDataSource {
  Future<String> addToCart(String listingID);
  Future<List<Cart>> fetchCart();
  Future<String> removeFromCart(String listingId);
}

class CartDataSourceImpl implements CartDataSource {
  final String _baseUrl = "https://2kps99nm-8080.uks1.devtunnels.ms";
  final http.Client client;

  CartDataSourceImpl({required this.client});

  @override
  Future<String> addToCart(String listingID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      print("ListingId $listingID");

      final response = await client.post(
        Uri.parse("$_baseUrl/api/cart/items"),
        body: json.encode({'listing_id': listingID}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData['message'];
      } else {
        throw Exception('Failed to add to cart: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  @override
  Future<String> removeFromCart(String listingID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      print("ListingId $listingID");

      final response = await client.delete(
        Uri.parse("$_baseUrl/api/cart/items/$listingID"), // Use DELETE endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return 'Item removed from cart successfully';
      } else {
        print(
            "Failed to remove item: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to remove item from cart: ${response.body}');
      }
    } catch (e) {
      print("Error in removeFromCart: $e");
      throw Exception('Error removing item from cart: $e');
    }
  }

  Future<List<Cart>> fetchCart() async {
    try {
      // print("DataSource: Starting getProducts");
      final prefs = await SharedPreferences.getInstance();
      // print("DataSource: SharedPreferences initialized");
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      final response = await client.get(
        Uri.parse("$_baseUrl/api/cart"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print("DataSource: Response received: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // print("Reached  Cart $responseData");
        return (responseData as List)
            .map((cart) => CartModel.fromJson(cart))
            .toList();
      } else {
        print(
            "Failed to fetch cart items: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to fetch cart items');
      }
    } catch (e) {
      print("Error in fetchcart: $e");
      rethrow;
    }
  }
}
