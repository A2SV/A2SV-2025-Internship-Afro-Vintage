import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class PerformCheckoutEvent extends CheckoutEvent {
  @override
  List<Object> get props => [];
}
