import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/usecases/checkout.dart';

import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_event.dart';
import 'package:mobile_frontend/features/consumer/checkout/presentation/bloc/checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUseCase performCheckoutUseCase;

  CheckoutBloc({
    required this.performCheckoutUseCase,
  }) : super(CheckoutEmpty()) {
    on<PerformCheckoutEvent>(_performCheckout);
  }

  Future<void> _performCheckout(
      PerformCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    print("CheckoutLoading state emitted");

    final result = await performCheckoutUseCase.call(NoParams());

    result.fold(
      (failure) {
        print("CheckoutError state emitted");
        emit(CheckoutError(message: _mapFailureToMessage(failure)));
      },
      (checkout) {
        print("CheckoutSuccess state emitted with data: $checkout");
        emit(CheckoutSuccess(message: 'Checkout successful', data: checkout));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again.';
    } else {
      return 'An unexpected error occurred.';
    }
  }
}
