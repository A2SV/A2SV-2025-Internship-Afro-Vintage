import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://2kps99nm-8081.uks1.devtunnels.ms';

  static Uri _buildUri(String endpoint) {
    if (endpoint.startsWith('http')) {
      return Uri.parse(endpoint);
    } else {
      return Uri.parse('$baseUrl$endpoint');
    }
  }

  Future<String> uploadImage(File image) async {
    // Implement actual upload logic
    throw UnimplementedError('uploadImage method is not implemented yet.');
  }

  Future<Map<String, dynamic>> post(String endpoint, {required Map body}) async {
    final uri = _buildUri(endpoint);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to create data: \\${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> put(String endpoint, {required Map body}) async {
    final uri = _buildUri(endpoint);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to update data: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final uri = _buildUri(endpoint);
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

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = _buildUri(endpoint);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to delete data: ${response.statusCode}');
    }
  }
}
