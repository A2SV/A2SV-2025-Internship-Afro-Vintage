import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/core/error/exception.dart';
import '../models/profile_model.dart';
import 'profile_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  ProfileRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  String? _extractUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final payloadMap = json.decode(payload);
      return payloadMap['user_id'] ?? payloadMap['id'];
    } catch (e) {
      return null;
    }
  }

  @override
 Future<ProfileModel> getProfile() async {
  try {
    final token = sharedPreferences.getString('auth_token');
    print('Token: $token');
    if (token == null) {
      print('No token found');
      throw ServerException();
    }

    final userId = _extractUserIdFromToken(token);
    print('Extracted userId: $userId');
    if (userId == null) {
      print('Failed to extract userId from token');
      throw ServerException();
    }

    final response = await client.get(
      Uri.parse('https://2kps99nm-8081.uks1.devtunnels.ms/api/users/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      print('Decoded data: $data');
      return ProfileModel.fromJson(data);
    } else {
      print('Non-200 response');
      throw ServerException();
    }
  } catch (e) {
    print('Exception in getProfile: $e');
    throw ServerException();
  }
}
}