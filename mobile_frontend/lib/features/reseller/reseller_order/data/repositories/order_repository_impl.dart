import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/data/datasources/order_remote_data_source.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order_history.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/repository/reseller_order_repository.dart';

class ResellerOrderRepositoryImpl implements ResellerOrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  ResellerOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderHistory>> getOrderHistory() async {
    try {
      final orderHistory = await remoteDataSource.getOrderHistory();
      return Right(orderHistory);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}