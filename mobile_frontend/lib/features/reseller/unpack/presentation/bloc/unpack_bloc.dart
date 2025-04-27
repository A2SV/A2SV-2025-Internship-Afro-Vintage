// lib/features/reseller/unpack/presentation/bloc/unpack_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/unpack_bundle_item.dart';
import 'unpack_event.dart';
import 'unpack_state.dart';

class UnpackBloc extends Bloc<UnpackEvent, UnpackState> {
  final UnpackBundleItem unpackBundleItem;

  UnpackBloc({required this.unpackBundleItem}) : super(UnpackInitial()) {
    on<UnpackBundleItemEvent>(_onUnpackBundleItem);
  }

  Future<void> _onUnpackBundleItem(
    UnpackBundleItemEvent event,
    Emitter<UnpackState> emit,
  ) async {
    emit(UnpackLoading());

    final result = await unpackBundleItem(event.item);

    result.fold(
      (failure) => emit(UnpackError(failure.toString())),
      (_) => emit(UnpackSuccess()),
    );
  }
}