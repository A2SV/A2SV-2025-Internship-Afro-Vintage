import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/models/dashboard_metrics_model.dart';
import '../../../../../helper/test_helper_mocks.mocks.dart';

void main() {
  late DashboardRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  late MockSharedPreferences mockSharedPreferences;
  const String tBaseUrl = 'https://2kps99nm-8081.uks1.devtunnels.ms';
  const String tAuthToken = 'test_token';

  setUp(() {
    mockHttpClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    dataSource = DashboardRemoteDataSourceImpl(
      client: mockHttpClient,
      sharedPreferences: mockSharedPreferences,
      baseUrl: tBaseUrl,
    );
  });

  group('getResellerMetrics', () {
    final tDashboardMetricsJson = {
      'totalBoughtBundles': 5,
      'totalItemsSold': 50,
      'rating': 4.5,
      'bestSelling': 25.0,
      'boughtBundles': [],
    };

    final tResponseJson = {
      'data': tDashboardMetricsJson,
    };

    test('should perform a GET request with proper headers', () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token'))
          .thenReturn(tAuthToken);
      when(mockHttpClient.get(
        Uri.parse('$tBaseUrl/reseller/metrics'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tAuthToken',
        },
      )).thenAnswer((_) async => http.Response(json.encode(tResponseJson), 200));

      // act
      await dataSource.getResellerMetrics();

      // assert
      verify(mockHttpClient.get(
        Uri.parse('$tBaseUrl/reseller/metrics'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tAuthToken',
        },
      ));
    });

    test('should return DashboardMetricsModel when the response code is 200',
        () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token'))
          .thenReturn(tAuthToken);
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(tResponseJson), 200));

      // act
      final result = await dataSource.getResellerMetrics();

      // assert
      expect(result, isA<DashboardMetricsModel>());
      expect(result.totalBoughtBundles, equals(5));
      expect(result.totalItemsSold, equals(50));
      expect(result.rating, equals(4.5));
      expect(result.bestSelling, equals(25.0));
      expect(result.boughtBundles, isEmpty);
    });

    test('should throw ServerException when the response code is 401', () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token'))
          .thenReturn(tAuthToken);
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      // act
      final call = dataSource.getResellerMetrics;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token'))
          .thenReturn(tAuthToken);
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('Server Error', 500));

      // act
      final call = dataSource.getResellerMetrics;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test('should throw ServerException when an error occurs', () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token'))
          .thenReturn(tAuthToken);
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenThrow(Exception());

      // act
      final call = dataSource.getResellerMetrics;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test('should handle empty auth token', () async {
      // arrange
      when(mockSharedPreferences.getString('auth_token')).thenReturn('');
      when(mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(json.encode(tResponseJson), 200));

      // act
      await dataSource.getResellerMetrics();

      // assert
      verify(mockHttpClient.get(
        any,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        },
      ));
    });
  });
}
