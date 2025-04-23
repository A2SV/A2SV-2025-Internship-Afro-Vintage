import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent {
  final User user;

  const SignupEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SigninEvent extends AuthEvent {
  final LoginUser user;

  const SigninEvent({required this.user});

  @override
  List<Object> get props => [user];
}
