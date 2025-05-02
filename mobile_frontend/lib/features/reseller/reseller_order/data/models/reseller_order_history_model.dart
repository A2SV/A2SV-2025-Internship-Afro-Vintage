// lib/features/reseller/orders/data/models/order_history_model.dart
import 'package:mobile_frontend/features/reseller/reseller_order/data/models/reseller_order_model.dart';
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order_history.dart';

class OrderHistoryModel extends OrderHistory {
  OrderHistoryModel({
    required List<BoughtOrder> bought,
    required List<SoldOrder> sold,
  }) : super(bought: bought, sold: sold);

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      bought: (json['bought'] as List)
          .map((item) => BoughtOrder(
                order: OrderModel.fromJson(item['order']),
                supplierName: item['supplierName'],
              ))
          .toList(),
      sold: (json['sold'] as List)
          .map((item) => SoldOrder(
                order: OrderModel.fromJson(item['order']),
                consumerName: item['consumerName'],
              ))
          .toList(),
    );
  }
}