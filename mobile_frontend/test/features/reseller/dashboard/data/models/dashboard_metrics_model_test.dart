import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/entities/dashboard_metrics.dart';

void main() {
  group('BoughtBundleModel', () {
    final tBoughtBundleModel = BoughtBundleModel(
      id: 'test_id',
      supplierId: 'supplier_1',
      title: 'Test Bundle',
      description: 'Test Description',
      sampleImage: 'test_image.jpg',
      quantity: 10,
      grade: 'A',
      sortingLevel: 'High',
      estimatedBreakdown: {'item1': 5, 'item2': 5},
      type: 'Clothing',
      price: 99.99,
      status: 'Active',
      createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
      declaredRating: 4,
      remainingItemCount: 8,
    );

    final tBoughtBundleJson = {
      'ID': 'test_id',
      'SupplierID': 'supplier_1',
      'Title': 'Test Bundle',
      'Description': 'Test Description',
      'SampleImage': 'test_image.jpg',
      'Quantity': 10,
      'Grade': 'A',
      'SortingLevel': 'High',
      'EstimatedBreakdown': {'item1': 5, 'item2': 5},
      'Type': 'Clothing',
      'Price': 99.99,
      'Status': 'Active',
      'CreatedAt': '2024-01-01T00:00:00Z',
      'DeclaredRating': 4,
      'RemainingItemCount': 8,
    };

    test('should be a subclass of BoughtBundle', () {
      expect(tBoughtBundleModel, isA<BoughtBundle>());
    });

    test('should create a valid model from JSON', () {
      final result = BoughtBundleModel.fromJson(tBoughtBundleJson);
      expect(result.id, equals(tBoughtBundleModel.id));
      expect(result.supplierId, equals(tBoughtBundleModel.supplierId));
      expect(result.title, equals(tBoughtBundleModel.title));
      expect(result.description, equals(tBoughtBundleModel.description));
      expect(result.sampleImage, equals(tBoughtBundleModel.sampleImage));
      expect(result.quantity, equals(tBoughtBundleModel.quantity));
      expect(result.grade, equals(tBoughtBundleModel.grade));
      expect(result.sortingLevel, equals(tBoughtBundleModel.sortingLevel));
      expect(result.estimatedBreakdown, equals(tBoughtBundleModel.estimatedBreakdown));
      expect(result.type, equals(tBoughtBundleModel.type));
      expect(result.price, equals(tBoughtBundleModel.price));
      expect(result.status, equals(tBoughtBundleModel.status));
      expect(result.createdAt, equals(tBoughtBundleModel.createdAt));
      expect(result.declaredRating, equals(tBoughtBundleModel.declaredRating));
      expect(result.remainingItemCount, equals(tBoughtBundleModel.remainingItemCount));
    });
  });

  group('DashboardMetricsModel', () {
    final tBoughtBundleModel = BoughtBundleModel(
      id: 'test_id',
      supplierId: 'supplier_1',
      title: 'Test Bundle',
      description: 'Test Description',
      sampleImage: 'test_image.jpg',
      quantity: 10,
      grade: 'A',
      sortingLevel: 'High',
      estimatedBreakdown: {'item1': 5, 'item2': 5},
      type: 'Clothing',
      price: 99.99,
      status: 'Active',
      createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
      declaredRating: 4,
      remainingItemCount: 8,
    );

    final tDashboardMetricsModel = DashboardMetricsModel(
      totalBoughtBundles: 5,
      totalItemsSold: 50,
      rating: 4.5,
      bestSelling: 25.0,
      boughtBundles: [tBoughtBundleModel],
    );

    final tDashboardMetricsJson = {
      'totalBoughtBundles': 5,
      'totalItemsSold': 50,
      'rating': 4.5,
      'bestSelling': 25.0,
      'boughtBundles': [
        {
          'ID': 'test_id',
          'SupplierID': 'supplier_1',
          'Title': 'Test Bundle',
          'Description': 'Test Description',
          'SampleImage': 'test_image.jpg',
          'Quantity': 10,
          'Grade': 'A',
          'SortingLevel': 'High',
          'EstimatedBreakdown': {'item1': 5, 'item2': 5},
          'Type': 'Clothing',
          'Price': 99.99,
          'Status': 'Active',
          'CreatedAt': '2024-01-01T00:00:00Z',
          'DeclaredRating': 4,
          'RemainingItemCount': 8,
        }
      ],
    };

    test('should be a subclass of DashboardMetrics', () {
      expect(tDashboardMetricsModel, isA<DashboardMetrics>());
    });

    test('should create a valid model from JSON', () {
      final result = DashboardMetricsModel.fromJson(tDashboardMetricsJson);
      expect(result.totalBoughtBundles, equals(tDashboardMetricsModel.totalBoughtBundles));
      expect(result.totalItemsSold, equals(tDashboardMetricsModel.totalItemsSold));
      expect(result.rating, equals(tDashboardMetricsModel.rating));
      expect(result.bestSelling, equals(tDashboardMetricsModel.bestSelling));
      expect(result.boughtBundles.length, equals(tDashboardMetricsModel.boughtBundles.length));
    });

    test('should handle null values with defaults', () {
      final jsonWithNulls = {
        'totalBoughtBundles': null,
        'totalItemsSold': null,
        'rating': null,
        'bestSelling': null,
        'boughtBundles': null,
      };

      final result = DashboardMetricsModel.fromJson(jsonWithNulls);
      expect(result.totalBoughtBundles, equals(0));
      expect(result.totalItemsSold, equals(0));
      expect(result.rating, equals(0.0));
      expect(result.bestSelling, equals(0.0));
      expect(result.boughtBundles, isEmpty);
    });

    test('should throw ServerException when JSON parsing fails', () {
      final invalidJson = {
        'totalBoughtBundles': 'not_an_int',
        'totalItemsSold': 50,
        'rating': 4.5,
        'bestSelling': 25.0,
        'boughtBundles': [],
      };

      expect(() => DashboardMetricsModel.fromJson(invalidJson), throwsA(isA<ServerException>()));
    });
  });
}
