import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, Profile>> call() async {
    return await repository.getProfile();
  }
} 