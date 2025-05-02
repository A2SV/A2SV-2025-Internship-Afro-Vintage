import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_state.dart';

void main() {
  group('DashboardState', () {
    test('should be an abstract class', () {
      expect(DashboardState, isA<Type>());
    });
  });

  group('DashboardInitial', () {
    test('should be a subclass of DashboardState', () {
      expect(DashboardInitial(), isA<DashboardState>());
    });

    test('should have empty props', () {
      expect(DashboardInitial().props, isEmpty);
    });

    test('should be equal when compared to another DashboardInitial instance', () {
      expect(DashboardInitial(), equals(DashboardInitial()));
    });
  });

  group('DashboardLoading', () {
    test('should be a subclass of DashboardState', () {
      expect(DashboardLoading(), isA<DashboardState>());
    });

    test('should have empty props', () {
      expect(DashboardLoading().props, isEmpty);
    });

    test('should be equal when compared to another DashboardLoading instance', () {
      expect(DashboardLoading(), equals(DashboardLoading()));
    });
  });

  group('DashboardLoaded', () {
    final tDashboardMetrics = DashboardMetricsModel(
      totalBoughtBundles: 5,
      totalItemsSold: 50,
      rating: 4.5,
      bestSelling: 25.0,
      boughtBundles: [],
    );

    test('should be a subclass of DashboardState', () {
      expect(
        DashboardLoaded(metrics: tDashboardMetrics),
        isA<DashboardState>(),
      );
    });

    test('should have correct props', () {
      final state = DashboardLoaded(metrics: tDashboardMetrics);
      expect(state.props, contains(tDashboardMetrics));
    });

    test('should be equal when compared to another DashboardLoaded instance with same metrics',
        () {
      final state1 = DashboardLoaded(metrics: tDashboardMetrics);
      final state2 = DashboardLoaded(metrics: tDashboardMetrics);

      expect(state1, equals(state2));
    });

    test('should not be equal when compared to another DashboardLoaded instance with different metrics',
        () {
      final state1 = DashboardLoaded(metrics: tDashboardMetrics);
      final state2 = DashboardLoaded(
        metrics: DashboardMetricsModel(
          totalBoughtBundles: 10,
          totalItemsSold: 100,
          rating: 4.0,
          bestSelling: 30.0,
          boughtBundles: [],
        ),
      );

      expect(state1, isNot(equals(state2)));
    });
  });

  group('DashboardError', () {
    const tErrorMessage = 'Test error message';

    test('should be a subclass of DashboardState', () {
      expect(
        const DashboardError(message: tErrorMessage),
        isA<DashboardState>(),
      );
    });

    test('should have correct props', () {
      final state = const DashboardError(message: tErrorMessage);
      expect(state.props, contains(tErrorMessage));
    });

    test('should be equal when compared to another DashboardError instance with same message',
        () {
      final state1 = const DashboardError(message: tErrorMessage);
      final state2 = const DashboardError(message: tErrorMessage);

      expect(state1, equals(state2));
    });

    test('should not be equal when compared to another DashboardError instance with different message',
        () {
      final state1 = const DashboardError(message: tErrorMessage);
      final state2 = const DashboardError(message: 'Different error message');

      expect(state1, isNot(equals(state2)));
    });
  });
}
