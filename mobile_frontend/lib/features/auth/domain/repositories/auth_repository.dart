import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signup(
      User signup); // Returns AuthResponse
  Future<Either<Failure, AuthResponse>> signin(
      LoginUser signup); // Returns AuthResponse
}
