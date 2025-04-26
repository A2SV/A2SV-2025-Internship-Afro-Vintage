import 'package:equatable/equatable.dart';
import '../../../domain/entities/payment.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final Payment payment;

  const PaymentSuccess({required this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PaymentProcessing extends PaymentState {
  final String orderId;
  final int estimatedTimeInSeconds;

  const PaymentProcessing({
    required this.orderId,
    this.estimatedTimeInSeconds = 180, // 3 minutes default
  });

  @override
  List<Object?> get props => [orderId, estimatedTimeInSeconds];
} 