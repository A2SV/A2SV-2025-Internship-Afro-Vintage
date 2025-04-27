import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String productId;

  const AddToCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;

  const RemoveFromCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class FetchCartEvent extends CartEvent {
  @override
  List<Object> get props => [];
}
