import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, Checkout>> checkout();
}
