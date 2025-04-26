import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/repositories/order_repository.dart';

class GetOrdersUseCase extends UseCase<List<OrderEntity>, NoParams> {
  final OrderRepository repository;

  GetOrdersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(NoParams) async {
    print("GetOrdersUseCase called");
    return await repository.getOrders();
  }
}
