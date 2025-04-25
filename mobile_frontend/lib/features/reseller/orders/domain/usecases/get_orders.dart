import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/orders/domain/repository/order_repository.dart';
import '../entities/order.dart';

class GetOrders implements UseCase<List<OrderItem>, NoParams> {
  final OrderRepository repository;

  GetOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderItem>>> call(NoParams params) {
    return repository.getOrders();
  }
}