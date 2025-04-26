import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import '../repositories/bundle_repository.dart';
import '../entities/bundle.dart';

class PurchaseBundle implements UseCase<Bundle, String> {
  final BundleRepository repository;

  PurchaseBundle(this.repository);

  @override
  Future<Either<Failure, Bundle>> call(String bundleId) {
    return repository.purchaseBundle(bundleId);
  }
}