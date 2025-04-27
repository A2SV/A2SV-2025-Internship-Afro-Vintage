import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/payment.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  Timer? _processingTimer;

  PaymentBloc() : super(PaymentInitial()) {
    on<ProcessPayment>(_onProcessPayment);
    on<CheckPaymentStatus>(_onCheckPaymentStatus);
    on<CancelPayment>(_onCancelPayment);
  }

  Future<void> _onProcessPayment(
    ProcessPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());

    try {
      // Simulate initial payment processing
      await Future.delayed(const Duration(seconds: 2));

      final orderId = 'order_${DateTime.now().millisecondsSinceEpoch}';
      emit(PaymentProcessing(orderId: orderId));

      // Simulate payment processing for 3 seconds instead of 3 minutes for demo
      await Future.delayed(const Duration(seconds: 3));

      // Create a successful payment
      final payment = Payment(
        id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
        fromUserId: 'current_user_id',
        toUserId: 'supplier_id',
        amount: event.amount,
        platformFee: event.amount * 0.02,
        sellerEarning: event.amount * 0.98,
        status: 'paid',
        referenceId: event.bundleId,
        type: 'b2b',
        createdAt: DateTime.now(),
      );

      emit(PaymentSuccess(payment: payment));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onCheckPaymentStatus(
    CheckPaymentStatus event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final payment = Payment(
        id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
        fromUserId: 'current_user_id',
        toUserId: 'supplier_id',
        amount: 0.0,
        platformFee: 0.0,
        sellerEarning: 0.0,
        status: 'paid',
        referenceId: event.orderId,
        type: 'b2b',
        createdAt: DateTime.now(),
      );

      emit(PaymentSuccess(payment: payment));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onCancelPayment(
    CancelPayment event,
    Emitter<PaymentState> emit,
  ) async {
    _processingTimer?.cancel();
    emit(PaymentInitial());
  }

  @override
  Future<void> close() {
    _processingTimer?.cancel();
    return super.close();
  }
} 