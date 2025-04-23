import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signin.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signup.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase signup;
  final SigninUseCase signin;

  AuthBloc({required this.signup, required this.signin}) : super(Empty()) {
    on<SignupEvent>(_signup);
    on<SigninEvent>(_signin);
  }

  Future<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(Loading());

    final result = await signup.call(SignupParams(user: event.user));

    result.fold(
      (failure) => emit(Error(message: 'Error in signup')),
      (authResponse) => emit(Success(
          message: 'Signup successful',
          data: authResponse)), // Include AuthResponse in Success state
    );
  }

  Future<void> _signin(SigninEvent event, Emitter<AuthState> emit) async {
    emit(Loading());

    final result = await signin.call(SigninParams(user: event.user));

    result.fold(
      (failure) => emit(Error(message: 'Error in signin')),
      (authResponse) =>
          emit(Success(message: 'Signin successful', data: authResponse)),
    );
  }
}
