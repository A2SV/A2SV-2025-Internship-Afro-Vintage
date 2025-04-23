import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';

class SigninUseCase extends UseCase<AuthResponse, SigninParams> {
  final AuthRepository repository;

  SigninUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthResponse>> call(SigninParams params) async {
    return await repository.signin(params.user); // Returns AuthResponse
  }
}

class SigninParams extends Equatable {
  final LoginUser user;

  const SigninParams({required this.user});

  @override
  List<Object?> get props => [user];
}
