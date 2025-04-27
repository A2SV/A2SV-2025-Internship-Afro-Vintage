import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/bundle.dart';

abstract class BundleRepository {
  Future<Either<Failure, List<Bundle>>> getAvailableBundles();
  Future<Either<Failure, Bundle>> getBundleDetails(String bundleId);
  Future<Either<Failure, List<Bundle>>> searchBundlesByTitle(String title);
  Future<Either<Failure, Bundle>> purchaseBundle(String bundleId);
}