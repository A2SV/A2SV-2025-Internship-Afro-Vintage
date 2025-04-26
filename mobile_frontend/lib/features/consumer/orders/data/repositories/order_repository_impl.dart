import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/orders/data/datasources/order_data_source.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryImpl({
    required this.orderDataSource,
  });

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      print("Repository: Fetching Orders");
      // Fetch orders from the data source
      final response = await orderDataSource.getOrders();

      // Convert the list of OrderModel to a list of OrderEntity
      final orders = response.map<OrderEntity>((order) => order).toList();

      print("Repository: Orders fetched successfully: $orders");
      return Right(orders);
    } on ServerException {
      print("Repository: ServerException occurred");
      return Left(ServerFailure());
    } catch (e) {
      print("Repository: Unexpected error occurred: $e");
      return Left(ServerFailure());
    }
  }
}
