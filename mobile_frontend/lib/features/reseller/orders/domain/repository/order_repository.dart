import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderItem>>> getOrders();
  Future<Either<Failure, OrderItem>> getOrderDetails(String orderId);
  Future<Either<Failure, OrderItem>> cancelOrder(String orderId);
  Future<Either<Failure, List<OrderItem>>> getOrdersByStatus(String status);
  Future<Either<Failure, OrderItem>> updateShippingAddress(String orderId, String newAddress);
}