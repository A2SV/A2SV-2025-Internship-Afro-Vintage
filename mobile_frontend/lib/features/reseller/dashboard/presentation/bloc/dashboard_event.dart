import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardMetrics extends DashboardEvent {}

class UpdateRemainingItems extends DashboardEvent {
  final String bundleId;
  final int remainingItems;

  const UpdateRemainingItems({
    required this.bundleId,
    required this.remainingItems,
  });

  @override
  List<Object?> get props => [bundleId, remainingItems];
}
