import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import '../repositories/bundle_repository.dart';
import '../entities/bundle.dart';

class GetAvailableBundles implements UseCase<List<Bundle>, NoParams> {
  final BundleRepository repository;

  GetAvailableBundles(this.repository);

  @override
  Future<Either<Failure, List<Bundle>>> call(NoParams params) {
    return repository.getAvailableBundles();
  }
}