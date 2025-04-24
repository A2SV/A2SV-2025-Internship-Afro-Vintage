import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/add_to_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/fetch_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/usecases/remove_from_cart.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_event.dart';
import 'package:mobile_frontend/features/consumer/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final FetchCartUseCase fetchCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.fetchCartUseCase,
    required this.removeFromCartUseCase,
  }) : super(Empty()) {
    on<AddToCartEvent>(_addToCart);
    on<FetchCartEvent>(_fetchCart);
    on<RemoveFromCartEvent>(_removeFromCart);
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      print("Bloc received Cart object: ${event.productId}");
      final message =
          await addToCartUseCase.call(AddtoCartParams(cart: event.productId));
      message.fold(
        (failure) => emit(Error(message: 'Failed to add item to cart')),
        (successMessage) =>
            emit(Success(data: successMessage, message: 'Hello')),
      );
    } catch (e) {
      emit(Error(message: 'Failed to add item to cart because of error'));
    }
  }

  Future<void> _fetchCart(FetchCartEvent event, Emitter<CartState> emit) async {
    emit(Loading());
    print("Loading state emitted");

    final result = await fetchCartUseCase.call(NoParams());
    // print("Result from use case: $result");

    result.fold(
      (failure) {
        print("Error state emitted");
        emit(Error(message: 'Error in signup'));
      },
      (cart) {
        // print("Success state emitted with data: $productResponse");
        emit(Success(message: 'FetchCart successful', data: cart));
      },
    );
  }

  Future<void> _removeFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      print("Bloc received request to remove item: ${event.productId}");
      final message = await removeFromCartUseCase
          .call(RemoveFromCartParams(cart: event.productId));
      message.fold(
        (failure) => emit(Error(message: 'Failed to remove item from cart')),
        (successMessage) {
          emit(
              Success(message: 'Item removed from cart', data: successMessage));
          add(FetchCartEvent()); // Refresh the cart after removal
        },
      );
    } catch (e) {
      emit(Error(message: 'Failed to remove item from cart because of error'));
    }
  }
}
