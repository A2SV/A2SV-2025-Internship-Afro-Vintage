import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order_history.dart';

abstract class ResellerOrderRepository {
  Future<Either<Failure, OrderHistory>> getOrderHistory();
}