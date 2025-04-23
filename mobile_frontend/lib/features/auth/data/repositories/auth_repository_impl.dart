import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, AuthResponse>> signup(User user) async {
    try {
      final authResponse = await authDataSource.signup(user);
      return Right(authResponse); // Return the entire AuthResponse
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signin(LoginUser user) async {
    try {
      final authResponse = await authDataSource.signin(user);
      return Right(authResponse);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
