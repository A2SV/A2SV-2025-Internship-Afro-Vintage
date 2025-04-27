import 'package:equatable/equatable.dart';
import '../../data/models/dashboard_data.dart';

// States
abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final DashboardData data;
  DashboardLoaded(this.data);
  @override
  List<Object?> get props => [data];
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
  @override
  List<Object?> get props => [message];
}
