import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import '../../domain/usecases/get_reseller_metrics.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetResellerMetrics getResellerMetrics;

  DashboardBloc({required this.getResellerMetrics})
      : super(DashboardInitial()) {
    on<LoadDashboardMetrics>(_onLoadDashboardMetrics);
  }

  Future<void> _onLoadDashboardMetrics(
    LoadDashboardMetrics event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    final result = await getResellerMetrics(NoParams());

    result.fold(
      (failure) => emit(DashboardError(message: failure.toString())),
      (metrics) => emit(DashboardLoaded(metrics: metrics)),
    );
  }
}
