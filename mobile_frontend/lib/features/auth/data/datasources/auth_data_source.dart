import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/features/auth/data/models/user_model.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';

class AuthResponse {
  final String token;
  final UserResponse? user; // Make the user field optional

  AuthResponse({required this.token, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: json['user'] != null
          ? UserResponse.fromJson(json['user'])
          : null, // Handle optional user
    );
  }
}

class UserResponse {
  final String id;
  final String role;
  final String username;

  UserResponse({required this.id, required this.role, required this.username});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      role: json['role'],
      username: json['username'],
    );
  }
}

abstract class AuthDataSource {
  Future<AuthResponse> signup(User user);
  Future<AuthResponse> signin(LoginUser user);
}

class AuthDataSourceImpl implements AuthDataSource {
  final String _baseUrl = "https://2kps99nm-8080.uks1.devtunnels.ms";

  final http.Client client;

  AuthDataSourceImpl({required this.client});

  @override
  Future<AuthResponse> signup(User user) async {
    final userModel = UserModel(
      username: user.username,
      email: user.email,
      password: user.password,
      role: user.role,
    );

    final response = await client.post(
      Uri.parse("$_baseUrl/auth/register"),
      body: json.encode(userModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return AuthResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  @override
  Future<AuthResponse> signin(LoginUser user) async {
    final userModel = LoginUserModel(
      username: user.username,
      password: user.password,
    );

    final response = await client.post(
      Uri.parse("$_baseUrl/auth/login"),
      body: json.encode(userModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return AuthResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to sign in: ${response.body}');
    }
  }
}
