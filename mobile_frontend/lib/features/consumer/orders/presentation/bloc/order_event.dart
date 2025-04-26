import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersEvent extends OrderEvent {
  const GetOrdersEvent();

  @override
  List<Object> get props => [];
}
