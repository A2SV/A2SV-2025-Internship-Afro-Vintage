import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/orders/domain/repository/order_repository.dart';
import '../entities/order.dart';

class GetOrdersByStatus implements UseCase<List<OrderItem>, String> {
  final OrderRepository repository;

  GetOrdersByStatus(this.repository);

  @override
  Future<Either<Failure, List<OrderItem>>> call(String status) {
    return repository.getOrdersByStatus(status);
  }
}