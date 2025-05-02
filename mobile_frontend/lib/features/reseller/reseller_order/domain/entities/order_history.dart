
// lib/features/reseller/orders/domain/entities/order_history.dart
import 'package:mobile_frontend/features/reseller/reseller_order/domain/entities/order.dart';

class OrderHistory {
  final List<BoughtOrder> bought;
  final List<SoldOrder> sold;

  OrderHistory({
    required this.bought,
    required this.sold,
  });
}

class BoughtOrder {
  final Order order;
  final String supplierName;

  BoughtOrder({
    required this.order,
    required this.supplierName,
  });
}

class SoldOrder {
  final Order order;
  final String consumerName;

  SoldOrder({
    required this.order,
    required this.consumerName,
  });
}