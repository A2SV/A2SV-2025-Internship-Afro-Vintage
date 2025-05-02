import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../../../../helper/test_helper_mocks.mocks.dart';

@GenerateMocks([DashboardRemoteDataSource, NetworkInfo])
void main() {
  late DashboardRepositoryImpl repository;
  late MockDashboardRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockDashboardRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DashboardRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getResellerMetrics', () {
    final tDashboardMetricsModel = DashboardMetricsModel(
      totalBoughtBundles: 5,
      totalItemsSold: 50,
      rating: 4.5,
      bestSelling: 25.0,
      boughtBundles: [],
    );

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getResellerMetrics())
          .thenAnswer((_) async => tDashboardMetricsModel);

      // act
      repository.getResellerMetrics();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getResellerMetrics())
          .thenAnswer((_) async => tDashboardMetricsModel);

      // act
      final result = await repository.getResellerMetrics();

      // assert
      verify(mockRemoteDataSource.getResellerMetrics());
      expect(result, equals(Right(tDashboardMetricsModel)));
    });

    test('should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getResellerMetrics())
          .thenThrow(ServerException());

      // act
      final result = await repository.getResellerMetrics();

      // assert
      verify(mockRemoteDataSource.getResellerMetrics());
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return unauthorized failure when the call to remote data source is unauthorized',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getResellerMetrics())
          .thenThrow(UnauthorizedException());

      // act
      final result = await repository.getResellerMetrics();

      // assert
      verify(mockRemoteDataSource.getResellerMetrics());
      expect(result, equals(Left(UnauthorizedFailure())));
    });

    test('should return network failure when there is no internet connection',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.getResellerMetrics();

      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
