part of 'create_bundle_bloc.dart';

abstract class CreateBundleState extends Equatable {
  const CreateBundleState();
}

class CreateBundleInitial extends CreateBundleState {
  @override
  List<Object> get props => [];
}

class CreateBundleLoading extends CreateBundleState {
  @override
  List<Object> get props => [];
}

class CreateBundleSuccess extends CreateBundleState {
  final String bundleId;
  const CreateBundleSuccess(this.bundleId);

  @override
  List<Object> get props => [bundleId];
}

class CreateBundleFailure extends CreateBundleState {
  final String error;
  const CreateBundleFailure(this.error);

  @override
  List<Object> get props => [error];
}