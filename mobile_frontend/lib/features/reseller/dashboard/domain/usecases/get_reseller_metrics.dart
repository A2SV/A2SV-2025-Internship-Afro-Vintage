import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import '../entities/dashboard_metrics.dart';
import '../repository/dashboard_repository.dart';

class GetResellerMetrics implements UseCase<DashboardMetrics, NoParams> {
  final DashboardRepository repository;

  GetResellerMetrics(this.repository);

  @override
  Future<Either<Failure, DashboardMetrics>> call(NoParams params) async {
    return await repository.getResellerMetrics();
  }
}
