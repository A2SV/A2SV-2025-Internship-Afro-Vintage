import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/marketplace/data/datasources/product_data_source.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/entities/product.dart';
import 'package:mobile_frontend/features/consumer/marketplace/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl({
    required this.productDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      print("Repository: Fetching products");
      final response = await productDataSource.getProducts();
      print("Repository: Products fetched successfully");
      return Right(response);
    } on ServerException {
      print("Repository: ServerException occurred");
      return Left(ServerFailure());
    }
  }
}
