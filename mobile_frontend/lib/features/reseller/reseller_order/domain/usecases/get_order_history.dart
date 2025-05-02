// lib/features/reseller/orders/domain/usecases/get_order_history.dart
import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/repository/reseller_order_repository.dart';
import '../entities/order_history.dart';

class GetOrderHistory implements UseCase<OrderHistory, NoParams> {
  final ResellerOrderRepository repository;

  GetOrderHistory(this.repository);

  @override
  Future<Either<Failure, OrderHistory>> call(NoParams params) async {
    return await repository.getOrderHistory();
  }
}