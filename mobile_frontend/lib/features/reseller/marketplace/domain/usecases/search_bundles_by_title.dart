import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import '../repositories/bundle_repository.dart';
import '../entities/bundle.dart';

class SearchBundlesByTitle implements UseCase<List<Bundle>, String> {
  final BundleRepository repository;

  SearchBundlesByTitle(this.repository);

  @override
  Future<Either<Failure, List<Bundle>>> call(String title) {
    return repository.searchBundlesByTitle(title);
  }
}