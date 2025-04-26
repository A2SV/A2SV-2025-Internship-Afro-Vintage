import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/orders/domain/repository/order_repository.dart';
import '../entities/order.dart';

class CancelOrder implements UseCase<OrderItem, String> {
  final OrderRepository repository;

  CancelOrder(this.repository);

  @override
  Future<Either<Failure, OrderItem>> call(String orderId) async {
    return repository.cancelOrder(orderId);
  }
}