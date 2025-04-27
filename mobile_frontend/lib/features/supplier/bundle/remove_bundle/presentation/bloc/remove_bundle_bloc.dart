import 'package:flutter_bloc/flutter_bloc.dart';
import 'remove_bundle_event.dart';
import 'remove_bundle_state.dart';

class RemoveBundleBloc extends Bloc<RemoveBundleEvent, RemoveBundleState> {
  RemoveBundleBloc() : super(RemoveBundleInitial()) {
    on<LoadBundles>((event, emit) async {
      emit(RemoveBundleLoading());
      try {
        // Simulate fetching bundles
        await Future.delayed(const Duration(seconds: 1));
        final bundles = [
          {'id': '1', 'name': 'Bundle 1'},
          {'id': '2', 'name': 'Bundle 2'},
          {'id': '3', 'name': 'Bundle 3'},
        ];
        emit(RemoveBundleLoaded(bundles));
      } catch (e) {
        emit(RemoveBundleError('Failed to load bundles'));
      }
    });
    on<RemoveBundle>((event, emit) async {
      emit(RemoveBundleLoading());
      try {
        // Simulate removal
        await Future.delayed(const Duration(milliseconds: 500));
        emit(RemoveBundleSuccess());
        add(LoadBundles());
      } catch (e) {
        emit(RemoveBundleError('Failed to remove bundle'));
      }
    });
  }
}
