import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/dashboard_metrics.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardMetrics>> getResellerMetrics();
}
