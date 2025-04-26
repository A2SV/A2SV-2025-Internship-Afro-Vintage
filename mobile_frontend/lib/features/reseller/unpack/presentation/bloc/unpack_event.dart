// lib/features/reseller/unpack/presentation/bloc/unpack_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/unpack_bundle.dart';

abstract class UnpackEvent extends Equatable {
  const UnpackEvent();

  @override
  List<Object> get props => [];
}

class UnpackBundleItemEvent extends UnpackEvent {
  final UnpackBundle item;

  const UnpackBundleItemEvent(this.item);

  @override
  List<Object> get props => [item];
}