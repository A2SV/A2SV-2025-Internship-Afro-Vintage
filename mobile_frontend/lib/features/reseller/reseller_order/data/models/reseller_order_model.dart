// lib/features/reseller/orders/data/models/order_model.dart
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required String id,
    required String resellerId,
    required String supplierId,
    required String bundleId,
    required double platformFee,
    required String consumerId,
    List<String>? productIds,
    required double totalPrice,
    required String status,
    required DateTime createdAt,
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
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      resellerId: json['reseller_id'],
      supplierId: json['supplier_id'],
      bundleId: json['bundle_id'],
      platformFee: json['platform_fee'].toDouble(),
      consumerId: json['consumer_id'],
      productIds: json['product_ids'] != null 
          ? List<String>.from(json['product_ids'])
          : null,
      totalPrice: json['total_price'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

