import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/models/dashboard_data.dart';

// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  Timer? _pollingTimer;

  DashboardBloc(this.repository) : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final data = await repository.fetchDashboardData();
        emit(DashboardLoaded(data));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
    // Removed periodic polling to prevent constant reloads
    // _pollingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   add(LoadDashboard());
    // });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
