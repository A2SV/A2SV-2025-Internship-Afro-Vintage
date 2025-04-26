import '../../domain/entities/order.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required String id,
    required String resellerId,
    required String supplierId,
    required String bundleId,
    required double platformFee,
    required String consumerId,
    required List<String> productIds,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
    required List<ProductOrderModel> products,
    required String resellerUsername,
  }) : super(
          id: id,
          resellerId: resellerId,
          supplierId: supplierId,
          bundleId: bundleId,
          platformFee: platformFee,
          consumerId: consumerId,
          productIds: productIds,
          totalPrice: totalPrice,
          status: status,
          createdAt: createdAt,
          products: products,
          resellerUsername: resellerUsername,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      resellerId: json['reseller_id'],
      supplierId: json['supplier_id'],
      bundleId: json['bundle_id'],
      platformFee: (json['platform_fee'] as num).toDouble(),
      consumerId: json['consumer_id'],
      productIds: List<String>.from(json['product_ids']),
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      products: (json['products'] as List<dynamic>)
          .map((product) => ProductOrderModel.fromJson(product))
          .toList(),
      resellerUsername: json['resellerUsername'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reseller_id': resellerId,
      'supplier_id': supplierId,
      'bundle_id': bundleId,
      'platform_fee': platformFee,
      'consumer_id': consumerId,
      'product_ids': productIds,
      'total_price': totalPrice,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'products': products
          .map((product) => (product as ProductOrderModel).toJson())
          .toList(),
      'resellerUsername': resellerUsername,
    };
  }
}

class ProductOrderModel extends ProductOrder {
  ProductOrderModel({
    required String id,
    required String title,
  }) : super(id: id, title: title);

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
