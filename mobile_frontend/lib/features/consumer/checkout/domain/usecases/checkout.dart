import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/entities/checkout.dart';
import 'package:mobile_frontend/features/consumer/checkout/domain/repositories/checkout_repository.dart';

class CheckoutUseCase extends UseCase<Checkout, NoParams> {
  final CheckoutRepository repository;

  CheckoutUseCase({required this.repository});

  @override
  Future<Either<Failure, Checkout>> call(NoParams) async {
    return await repository.checkout();
  }
}
