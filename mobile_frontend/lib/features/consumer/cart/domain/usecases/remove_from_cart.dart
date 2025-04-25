import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase extends UseCase<String, RemoveFromCartParams> {
  final CartRepository repository;

  RemoveFromCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RemoveFromCartParams params) async {
    return await repository.removeFromCart(params.cart);
  }
}

class RemoveFromCartParams extends Equatable {
  final String cart;

  const RemoveFromCartParams({required this.cart});

  @override
  List<Object?> get props => [cart];
}
