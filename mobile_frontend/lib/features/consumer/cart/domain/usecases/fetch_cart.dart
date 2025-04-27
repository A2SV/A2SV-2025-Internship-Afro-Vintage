import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/entities/cart.dart';
import 'package:mobile_frontend/features/consumer/cart/domain/repositories/cart_repository.dart';

class FetchCartUseCase extends UseCase<List<Cart>, NoParams> {
  final CartRepository repository;

  FetchCartUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Cart>>> call(NoParams) async {
    return await repository.fetchCart();
  }
}
