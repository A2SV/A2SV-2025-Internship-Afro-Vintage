import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String resellerId;
  final String supplierId;
  final String bundleId;
  final double platformFee;
  final String consumerId;
  final List<String> productIds;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  final List<ProductOrder> products;
  final String resellerUsername;

  OrderEntity({
    required this.id,
    required this.resellerId,
    required this.supplierId,
    required this.bundleId,
    required this.platformFee,
    required this.consumerId,
    required this.productIds,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.products,
    required this.resellerUsername,
  });

  @override
  List<Object?> get props => [
        id,
        resellerId,
        supplierId,
        bundleId,
        platformFee,
        consumerId,
        productIds,
        totalPrice,
        status,
        createdAt,
        products,
        resellerUsername,
      ];
}

class ProductOrder extends Equatable {
  final String id;
  final String title;

  ProductOrder({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
