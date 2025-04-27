import 'package:equatable/equatable.dart';

abstract class RemoveBundleState extends Equatable {
  const RemoveBundleState();
  @override
  List<Object?> get props => [];
}

class RemoveBundleInitial extends RemoveBundleState {}
class RemoveBundleLoading extends RemoveBundleState {}
class RemoveBundleLoaded extends RemoveBundleState {
  final List<dynamic> bundles;
  const RemoveBundleLoaded(this.bundles);
  @override
  List<Object?> get props => [bundles];
}
class RemoveBundleError extends RemoveBundleState {
  final String message;
  const RemoveBundleError(this.message);
  @override
  List<Object?> get props => [message];
}
class RemoveBundleSuccess extends RemoveBundleState {}
