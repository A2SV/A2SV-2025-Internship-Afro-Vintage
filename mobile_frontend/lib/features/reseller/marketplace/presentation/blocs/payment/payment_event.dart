import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class ProcessPayment extends PaymentEvent {
  final String bundleId;
  final double amount;

  const ProcessPayment({
    required this.bundleId,
    required this.amount,
  });

  @override
  List<Object?> get props => [bundleId, amount];
}

class CheckPaymentStatus extends PaymentEvent {
  final String orderId;

  const CheckPaymentStatus({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class CancelPayment extends PaymentEvent {
  final String orderId;

  const CancelPayment({required this.orderId});

  @override
  List<Object?> get props => [orderId];
} 