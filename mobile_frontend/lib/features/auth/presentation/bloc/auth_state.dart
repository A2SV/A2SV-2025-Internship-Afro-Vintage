import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Empty extends AuthState {
  const Empty();
}

class Loading extends AuthState {
  const Loading();
}

class Loaded extends AuthState {
  final List<User> user;

  const Loaded({required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends AuthState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Success extends AuthState {
  final String message;
  final AuthResponse data; // Include AuthResponse object

  const Success({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}
