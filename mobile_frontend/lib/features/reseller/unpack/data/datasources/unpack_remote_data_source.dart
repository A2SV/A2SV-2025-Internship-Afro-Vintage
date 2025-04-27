// lib/features/reseller/unpack/data/datasources/unpack_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/reseller/unpack/data/models/unpack_bundle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_frontend/core/error/exception.dart';

abstract class UnpackRemoteDataSource {
  Future<void> unpackBundleItem(UnpackBundleModel item);
}

class UnpackRemoteDataSourceImpl implements UnpackRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String baseUrl;

  UnpackRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
    this.baseUrl = "https://a2sv-2025-internship-afro-vintage.onrender.com",
  });

  Map<String, String> get _headers {
    final token = sharedPreferences.getString('auth_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<void> unpackBundleItem(UnpackBundleModel item) async {
    try {
      // Create the request payload
      final payload = {
        'title': item.clothName,
        'description': item.description,
        'size': 'M',  // You might want to make this configurable
        'type': item.category,
        'grade': item.status,
        'price': item.price,
        'image_url': item.imageUrl,
        'bundle_id': item.bundleId,
      };

      final response = await client.post(
        Uri.parse('$baseUrl/products'),
        headers: _headers,
        body: json.encode(payload),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('Error in unpackBundleItem: $e');
      throw ServerException();
    }
  }
}

