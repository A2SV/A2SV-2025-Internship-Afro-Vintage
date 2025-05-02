// test/mocks/user_service_mock.dart

import 'package:http/http.dart' as http;
import 'package:mobile_frontend/core/network/network_info.dart';
import 'package:mobile_frontend/features/reseller/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/repository/dashboard_repository.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/usecases/get_reseller_metrics.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([DashboardRepository,DashboardRemoteDataSource,NetworkInfo,GetResellerMetrics, http.Client, SharedPreferences])
void main() {}
