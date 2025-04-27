import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class Empty extends ProductState {
  const Empty();
}

class Loading extends ProductState {
  const Loading();
}

class Loaded extends ProductState {
  final List<Product> products;

  const Loaded({required this.products});

  @override
  List<Object> get props => [products];
}

class Error extends ProductState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Success extends ProductState {
  final String message;
  final List<Product> data; // Include ProductResponse object

  const Success({required this.message, required this.data});

  @override
  List<Object> get props => [message, data];
}
