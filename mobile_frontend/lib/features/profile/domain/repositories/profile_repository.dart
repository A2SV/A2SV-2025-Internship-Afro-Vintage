import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile();
} 