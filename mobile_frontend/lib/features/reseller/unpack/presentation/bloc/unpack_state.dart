// lib/features/reseller/unpack/presentation/bloc/unpack_state.dart
import 'package:equatable/equatable.dart';

abstract class UnpackState extends Equatable {
  const UnpackState();

  @override
  List<Object> get props => [];
}

class UnpackInitial extends UnpackState {}

class UnpackLoading extends UnpackState {}

class UnpackSuccess extends UnpackState {}

class UnpackError extends UnpackState {
  final String message;

  const UnpackError(this.message);

  @override
  List<Object> get props => [message];
}