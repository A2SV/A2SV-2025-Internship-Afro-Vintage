import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_state.dart';
import '../../../../../helper/test_helper_mocks.mocks.dart';

void main() {
  late DashboardBloc bloc;
  late MockGetResellerMetrics mockGetResellerMetrics;

  setUp(() {
    mockGetResellerMetrics = MockGetResellerMetrics();
    bloc = DashboardBloc(getResellerMetrics: mockGetResellerMetrics);
  });

  final tDashboardMetrics = DashboardMetricsModel(
    totalBoughtBundles: 5,
    totalItemsSold: 50,
    rating: 4.5,
    bestSelling: 25.0,
    boughtBundles: [],
  );

  test('initial state should be DashboardInitial', () {
    // assert
    expect(bloc.state, equals(DashboardInitial()));
  });

  group('LoadDashboardMetrics', () {
    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetResellerMetrics(any))
          .thenAnswer((_) async => Right(tDashboardMetrics));

      // assert later
      final expected = [
        DashboardLoading(),
        DashboardLoaded(metrics: tDashboardMetrics),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(LoadDashboardMetrics());
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetResellerMetrics(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        DashboardLoading(),
        DashboardError(message: ServerFailure().toString()),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(LoadDashboardMetrics());
    });

    test('should emit [Loading, Error] when getting data fails with NetworkFailure',
        () async {
      // arrange
      when(mockGetResellerMetrics(any))
          .thenAnswer((_) async => Left(NetworkFailure()));

      // assert later
      final expected = [
        DashboardLoading(),
        DashboardError(message: NetworkFailure().toString()),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(LoadDashboardMetrics());
    });

    test('should emit [Loading, Error] when getting data fails with UnauthorizedFailure',
        () async {
      // arrange
      when(mockGetResellerMetrics(any))
          .thenAnswer((_) async => Left(UnauthorizedFailure()));

      // assert later
      final expected = [
        DashboardLoading(),
        DashboardError(message: UnauthorizedFailure().toString()),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(LoadDashboardMetrics());
    });
  });
}
