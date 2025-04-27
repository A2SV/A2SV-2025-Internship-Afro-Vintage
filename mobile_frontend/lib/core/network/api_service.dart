import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<String> uploadImage(File image) async {
    // Implement actual upload logic
    throw UnimplementedError('uploadImage method is not implemented yet.');
  }

  Future<Map<String, dynamic>> post(String endpoint, {required Map body}) {
    // Implement POST request
    throw UnimplementedError('post method is not implemented yet.');
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final uri = Uri.parse(endpoint);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}