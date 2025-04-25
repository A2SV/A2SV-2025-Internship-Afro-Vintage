import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/reseller/marketplace/domain/entities/bundle.dart';
import '../../domain/repositories/bundle_repository.dart';
import '../datasources/bundle_remote_data_source.dart';

class BundleRepositoryImpl implements BundleRepository {
  final BundleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BundleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Bundle>>> getAvailableBundles() async {
    if (await networkInfo.isConnected) {
      try {
        final bundles = await remoteDataSource.getAvailableBundles();
        return Right(bundles);
      } catch (e) {
        return  Left(ServerFailure());
      }
    } else {
      return  Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Bundle>> getBundleDetails(String bundleId) async {
    if (await networkInfo.isConnected) {
      try {
        final bundle = await remoteDataSource.getBundleDetails(bundleId);
        return Right(bundle);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Bundle>>> searchBundlesByTitle(String title) async {
    if (await networkInfo.isConnected) {
      try {
        final bundles = await remoteDataSource.searchBundlesByTitle(title);
        return Right(bundles);
      } catch (e) {
        return Left( ServerFailure());
      }
    } else {
      return  Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Bundle>> purchaseBundle(String bundleId) async {
    if (await networkInfo.isConnected) {
      try {
        print('Repository: Attempting to purchase bundle: $bundleId');
        final bundle = await remoteDataSource.purchaseBundle(bundleId);
        print('Repository: Bundle purchase successful');
        return Right(bundle);
      } catch (e) {
        print('Repository: Error purchasing bundle: $e');
        return Left(ServerFailure());
      }
    } else {
      print('Repository: No internet connection');
      return Left(NetworkFailure());
    }
  }
  
  
}