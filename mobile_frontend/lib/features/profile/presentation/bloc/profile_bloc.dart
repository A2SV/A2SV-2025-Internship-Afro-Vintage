import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;

  ProfileBloc({required this.getProfile}) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await getProfile();
      result.fold(
        (failure) => emit(ProfileError(message: 'Failed to load profile')),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    });
  }
} 