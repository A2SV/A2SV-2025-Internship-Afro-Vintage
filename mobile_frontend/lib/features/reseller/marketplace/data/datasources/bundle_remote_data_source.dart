import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bundle_model.dart';
import 'package:mobile_frontend/core/error/exception.dart';

abstract class BundleRemoteDataSource {
  Future<List<BundleModel>> getAvailableBundles();
  Future<BundleModel> getBundleDetails(String bundleId);
  Future<List<BundleModel>> searchBundlesByTitle(String title);
  Future<BundleModel> purchaseBundle(String bundleId);
}

class BundleRemoteDataSourceImpl implements BundleRemoteDataSource {
  final http.Client client;
  final String _baseUrl;
  final SharedPreferences sharedPreferences;

  BundleRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  }) : _baseUrl = "https://2kps99nm-8081.uks1.devtunnels.ms";

  Map<String, String> get _headers {
    final token = sharedPreferences.getString('auth_token') ?? '';
    print("token $token");
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<List<BundleModel>> getAvailableBundles() async {
    final url = '$_baseUrl/bundles/available';
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        // Handle case where response is "null" or empty
        if (response.body == "null" || response.body.isEmpty) {
          print('Warning: Response body is null or empty');
          return []; // Return empty list instead of throwing error
        }
        // print(response.body);

        final decoded = json.decode(response.body);

        // Handle different response formats
        if (decoded == null) {
          return [];
        } else if (decoded is List) {
          return decoded.map((json) => BundleModel.fromJson(json)).toList();
        } else if (decoded is Map<String, dynamic>) {
          // Check if response is wrapped in a data field
          final bundles = decoded['data'] ?? decoded['bundles'] ?? [];
          if (bundles is List) {
            return bundles.map((json) => BundleModel.fromJson(json)).toList();
          }
        }

        return []; // Return empty list if format doesn't match
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e, stackTrace) {
      throw ServerException();
    }
  }

  @override
  Future<BundleModel> getBundleDetails(String bundleId) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/bundles/$bundleId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return BundleModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<BundleModel>> searchBundlesByTitle(String title) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/bundles/search?title=$title'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => BundleModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<BundleModel> purchaseBundle(String bundleId) async {
    try {
      print('Attempting to purchase bundle: $bundleId');
      print('Headers: $_headers');

      final response = await client.post(
        Uri.parse('$_baseUrl/orders'),
        headers: _headers,
        body: json.encode({
          'bundle_id': bundleId,
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return BundleModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        print('Unauthorized: Token might be invalid or expired');
        throw UnauthorizedException();
      } else {
        print('Server error: ${response.statusCode}');
        throw ServerException();
      }
    } catch (e) {
      print('Error in purchaseBundle: $e');
      throw ServerException();
    }
  }
}
