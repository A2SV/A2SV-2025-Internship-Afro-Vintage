import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class Empty extends CartState {
  const Empty();
}

class Loading extends CartState {
  const Loading();
}

class Loaded extends CartState {
  final String message;

  const Loaded({required this.message});

  @override
  List<Object> get props => [message];
}

class Error extends CartState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Success extends CartState {
  final String message;
  final Object? data;

  const Success({required this.message, this.data});

  @override
  List<Object> get props => [message, data ?? Object()];
}
