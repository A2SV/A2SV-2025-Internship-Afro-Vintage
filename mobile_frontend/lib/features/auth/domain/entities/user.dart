import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String password;
  final String role; // Change role to a String

  const User({
    required this.username,
    required this.email,
    required this.password,
    required this.role, // Initialize role as a String
  });

  @override
  List<Object?> get props => [username, email, password, role];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'role': role, // Keep role as a string
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      role: map['role'], // Directly assign role as a string
    );
  }
}

class LoginUser extends Equatable {
  final String username;
  final String password;

  const LoginUser({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
