import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bundle_model.dart';

class BundleRemoteDataSource {
  final String baseUrl = 'https://2kps99nm-8081.uks1.devtunnels.ms';

  Future<List<BundleModel>> fetchBundles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('$baseUrl/bundles'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['success'] == true && body['data'] is List) {
        print('[DEBUG] Raw bundles data: \\n${body['data']}');
        return (body['data'] as List)
            .map((item) => BundleModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load bundles');
    }
  }
}
