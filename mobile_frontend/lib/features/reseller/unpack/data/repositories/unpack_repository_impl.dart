// lib/features/reseller/unpack/data/repositories/unpack_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/reseller/unpack/data/models/unpack_bundle_model.dart';
import 'package:mobile_frontend/features/reseller/unpack/domain/repository/unpack_repository.dart';
import '../../domain/entities/unpack_bundle.dart';
import '../datasources/unpack_remote_data_source.dart';



class UnpackRepositoryImpl implements UnpackRepository {
  final UnpackRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UnpackRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> unpackBundleItem(UnpackBundle item) async {
    if (await networkInfo.isConnected) {
      try {
        final unpackItemModel = UnpackBundleModel(
          clothName: item.clothName,
          category: item.category,
          status: item.status,
          price: item.price,
          description: item.description,
          imageUrl: item.imageUrl,
          bundleId: item.bundleId,
        );
        
        await remoteDataSource.unpackBundleItem(unpackItemModel);
        return const Right(null);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}