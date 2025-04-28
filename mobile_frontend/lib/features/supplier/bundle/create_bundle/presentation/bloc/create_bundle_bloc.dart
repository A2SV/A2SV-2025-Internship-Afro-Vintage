import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/bundle_repository.dart';

part 'create_bundle_event.dart';
part 'create_bundle_state.dart';

class CreateBundleBloc extends Bloc<CreateBundleEvent, CreateBundleState> {
  final BundleRepository repository;

  CreateBundleBloc({required this.repository}) : super(CreateBundleInitial()) {
    on<CreateBundleSubmitted>(_onCreateBundleSubmitted);
  }

  Future<void> _onCreateBundleSubmitted(
    CreateBundleSubmitted event,
    Emitter<CreateBundleState> emit,
  ) async {
    emit(CreateBundleLoading());
    try {
      final bundleId = await repository.createBundle(
        name: event.name,
        itemCount: event.itemCount,
        type: event.type,
        price: event.price,
        description: event.description,
        imageFiles: event.imageUrls.map((path) => File(path)).toList(),
        grade: event.grade,
        declaredRating: event.declaredRating,
      );
      emit(CreateBundleSuccess(bundleId));
    } catch (e) {
      emit(CreateBundleFailure(e.toString()));
    }
  }
}