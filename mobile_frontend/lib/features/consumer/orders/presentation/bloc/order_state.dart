import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderEmpty extends OrderState {
  const OrderEmpty();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderLoaded extends OrderState {
  final List<OrderEntity> orders;

  const OrderLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderSuccess extends OrderState {
  final String message;
  final List<OrderEntity> data;

  const OrderSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}
