import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/usecases/get_reseller_metrics.dart';
import '../../../../../helper/test_helper_mocks.mocks.dart';


void main() {
  late GetResellerMetrics usecase;
  late MockDashboardRepository mockRepository;

  setUp(() {
    mockRepository = MockDashboardRepository();
    usecase = GetResellerMetrics(mockRepository);
  });

  final tDashboardMetrics = DashboardMetricsModel(
    totalBoughtBundles: 5,
    totalItemsSold: 50,
    rating: 4.5,
    bestSelling: 25.0,
    boughtBundles: [],
  );

  test('should get dashboard metrics from the repository', () async {
    // arrange
    when(mockRepository.getResellerMetrics())
        .thenAnswer((_) async => Right(tDashboardMetrics));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Right(tDashboardMetrics));
    verify(mockRepository.getResellerMetrics());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository call fails', () async {
    // arrange
    when(mockRepository.getResellerMetrics())
        .thenAnswer((_) async => Left(ServerFailure()));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Left(ServerFailure()));
    verify(mockRepository.getResellerMetrics());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NetworkFailure when repository call fails', () async {
    // arrange
    when(mockRepository.getResellerMetrics())
        .thenAnswer((_) async => Left(NetworkFailure()));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Left(NetworkFailure()));
    verify(mockRepository.getResellerMetrics());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return UnauthorizedFailure when repository call fails', () async {
    // arrange
    when(mockRepository.getResellerMetrics())
        .thenAnswer((_) async => Left(UnauthorizedFailure()));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, Left(UnauthorizedFailure()));
    verify(mockRepository.getResellerMetrics());
    verifyNoMoreInteractions(mockRepository);
  });
}
