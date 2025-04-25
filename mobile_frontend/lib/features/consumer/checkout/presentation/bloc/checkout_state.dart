import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutEmpty extends CheckoutState {
  const CheckoutEmpty();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutLoaded extends CheckoutState {
  final String message;

  const CheckoutLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class CheckoutError extends CheckoutState {
  final String message;

  const CheckoutError({required this.message});

  @override
  List<Object> get props => [message];
}

class CheckoutSuccess extends CheckoutState {
  final String message;
  final Checkout data;

  const CheckoutSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}
