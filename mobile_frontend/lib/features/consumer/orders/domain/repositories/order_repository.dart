import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
