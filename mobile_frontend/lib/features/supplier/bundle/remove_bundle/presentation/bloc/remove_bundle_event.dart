import 'package:equatable/equatable.dart';

abstract class RemoveBundleEvent extends Equatable {
  const RemoveBundleEvent();
  @override
  List<Object?> get props => [];
}

class LoadBundles extends RemoveBundleEvent {}
class RemoveBundle extends RemoveBundleEvent {
  final String bundleId;
  const RemoveBundle(this.bundleId);
  @override
  List<Object?> get props => [bundleId];
}
