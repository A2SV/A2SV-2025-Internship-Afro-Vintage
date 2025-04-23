import 'package:mobile_frontend/features/auth/domain/entities/user.dart';

// Model for signup
class UserModel extends User {
  const UserModel({
    required super.username,
    required super.email,
    required super.password,
    required super.role, // Role is now a String
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "role": role,
    };
  }
}

class LoginUserModel extends LoginUser {
  const LoginUserModel({
    required super.username,
    required super.password,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
