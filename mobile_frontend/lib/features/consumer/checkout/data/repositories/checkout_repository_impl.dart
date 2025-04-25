import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/cart/data/datasources/cart_data_source.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';
import 'package:mobile_frontend/features/consumer/checkout/data/datasources/checkout_data_source.dart';
import 'package:mobile_frontend/features/consumer/checkout/data/models/checkout_model.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource checkoutDataSource;

  CheckoutRepositoryImpl({required this.checkoutDataSource});

  @override
  Future<Either<Failure, Checkout>> checkout() async {
    try {
      print("Repository: Fetching checkout data");
      final response = await checkoutDataSource.checkout();
      print("Repository: Checkout data fetched successfully $response");

      // Ensure proper conversion if needed
      return Right(response.toEntity());
    } on ServerException {
      print("Repository: ServerException occurred");
      return Left(ServerFailure());
    }
  }
}
