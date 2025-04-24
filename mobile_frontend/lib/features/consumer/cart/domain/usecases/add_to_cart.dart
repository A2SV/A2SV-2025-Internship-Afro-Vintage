import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase extends UseCase<String, AddtoCartParams> {
  final CartRepository repository;

  AddToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddtoCartParams params) async {
    print("Usecase listin ${params.cart}");
    return await repository.addToCart(params.cart);
  }
}

class AddtoCartParams extends Equatable {
  final String cart;

  const AddtoCartParams({required this.cart});

  @override
  List<Object?> get props => [cart];
}
