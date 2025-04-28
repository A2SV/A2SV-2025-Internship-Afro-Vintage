import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required String id,
    required String username,
    required String email,
    required String role,
  }) : super(
          id: id,
          username: username,
          email: email,
          role: role,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
