import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/consumer/reviews/data/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReviewDataSource {
  Future<String> addReview(ReviewModel review);
}

class ReviewDataSourceImpl implements ReviewDataSource {
  final String _baseUrl = "https://2kps99nm-8081.uks1.devtunnels.ms";
  final http.Client client;

  ReviewDataSourceImpl({required this.client});

  @override
  Future<String> addReview(ReviewModel review) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      print("DataSource: Token retrieved: $token");
      print("body: ${review.toMap()}");

      final response = await client.post(
        Uri.parse("$_baseUrl/products/${review.productId}/reviews"),
        body: json.encode(review.toMap()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Boyssss: ${responseData['message']}");
        return responseData['message'] ?? 'Review added successfully';
      } else {
        throw Exception('Failed to add review: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding review: $e');
    }
  }
}
