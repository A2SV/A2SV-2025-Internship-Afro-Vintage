import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order_history.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final OrderHistory orderHistory;

  const OrderLoaded(this.orderHistory);

  @override
  List<Object> get props => [orderHistory];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}
