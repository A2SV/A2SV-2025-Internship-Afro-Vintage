import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';

class SignupUseCase extends UseCase<AuthResponse, SignupParams> {
  final AuthRepository repository;

  SignupUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthResponse>> call(SignupParams params) async {
    return await repository.signup(params.user); // Returns AuthResponse
  }
}

class SignupParams extends Equatable {
  final User user;

  const SignupParams({required this.user});

  @override
  List<Object?> get props => [user];
}
