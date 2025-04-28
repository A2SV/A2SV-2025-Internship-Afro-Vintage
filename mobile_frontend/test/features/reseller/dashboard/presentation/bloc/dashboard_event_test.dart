import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/features/reseller/dashboard/presentation/bloc/dashboard_event.dart';

void main() {
  group('DashboardEvent', () {
    test('should be an abstract class', () {
      expect(DashboardEvent, isA<Type>());
    });
  });

  group('LoadDashboardMetrics', () {
    test('should be a subclass of DashboardEvent', () {
      expect(LoadDashboardMetrics(), isA<DashboardEvent>());
    });

    test('should have empty props', () {
      expect(LoadDashboardMetrics().props, isEmpty);
    });

    test('should be equal when compared to another LoadDashboardMetrics instance',
        () {
      expect(LoadDashboardMetrics(), equals(LoadDashboardMetrics()));
    });
  });

  group('UpdateRemainingItems', () {
    const tBundleId = 'test_bundle_id';
    const tRemainingItems = 10;

    test('should be a subclass of DashboardEvent', () {
      expect(
        const UpdateRemainingItems(
          bundleId: tBundleId,
          remainingItems: tRemainingItems,
        ),
        isA<DashboardEvent>(),
      );
    });

    test('should have correct props', () {
      final event = const UpdateRemainingItems(
        bundleId: tBundleId,
        remainingItems: tRemainingItems,
      );

      expect(event.props, containsAll([tBundleId, tRemainingItems]));
    });

    test('should be equal when compared to another UpdateRemainingItems instance with same values',
        () {
      final event1 = const UpdateRemainingItems(
        bundleId: tBundleId,
        remainingItems: tRemainingItems,
      );
      final event2 = const UpdateRemainingItems(
        bundleId: tBundleId,
        remainingItems: tRemainingItems,
      );

      expect(event1, equals(event2));
    });

    test('should not be equal when compared to another UpdateRemainingItems instance with different values',
        () {
      final event1 = const UpdateRemainingItems(
        bundleId: tBundleId,
        remainingItems: tRemainingItems,
      );
      final event2 = const UpdateRemainingItems(
        bundleId: 'different_bundle_id',
        remainingItems: 20,
      );

      expect(event1, isNot(equals(event2)));
    });
  });
}
