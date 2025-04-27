import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/repository/dashboard_repository.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardMetrics>> getResellerMetrics() async {
    if (await networkInfo.isConnected) {
      try {
        final metrics = await remoteDataSource.getResellerMetrics();
        return Right(metrics);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
