import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/repositories/product_repository.dart';

class GetProductsUseCase extends UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams) async {
    print("GetProductsUseCase called");
    return await repository.getProducts();
  }
}
