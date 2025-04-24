import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, String>> addToCart(String cart);
  Future<Either<Failure, String>> removeFromCart(String cart);
  Future<Either<Failure, List<Cart>>> fetchCart();
}
