import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/cart/data/datasources/cart_data_source.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<Either<Failure, String>> addToCart(String cart) async {
    print("Repository listin ${cart}");
    try {
      final response = await cartDataSource.addToCart(cart);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> fetchCart() async {
    try {
      print("Repository: Fetching products");
      final response = await cartDataSource.fetchCart();
      print("Repository: Products fetched successfully");
      return Right(response);
    } on ServerException {
      print("Repository: ServerException occurred");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeFromCart(String cart) async {
    try {
      // print(
      //     "Repository: Removing item from cart with listingID: ${cart.listing_id}");
      final response = await cartDataSource.removeFromCart(cart);
      // print("Repository: Item removed successfully");
      return Right(response);
    } on ServerException {
      // print("Repository: ServerException occurred while removing item");
      return Left(ServerFailure());
    } catch (e) {
      // print("Repository: Unexpected error occurred: $e");
      return Left(ServerFailure());
    }
  }
}
