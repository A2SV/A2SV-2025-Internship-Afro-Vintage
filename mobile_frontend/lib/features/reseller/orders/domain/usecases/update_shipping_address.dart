import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/reseller/orders/domain/repository/order_repository.dart';
import '../entities/order.dart';

class UpdateShippingAddress implements UseCase<OrderItem, UpdateShippingAddressParams> {
  final OrderRepository repository;

  UpdateShippingAddress(this.repository);

  @override
  Future<Either<Failure, OrderItem>> call(UpdateShippingAddressParams params) {
    return repository.updateShippingAddress(params.orderId, params.newAddress);
  }
}

class UpdateShippingAddressParams {
  final String orderId;
  final String newAddress;

  UpdateShippingAddressParams({
    required this.orderId,
    required this.newAddress,
  });
}