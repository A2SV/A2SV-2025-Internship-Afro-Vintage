// lib/features/reseller/orders/domain/entities/order.dart
class Order {
  final String id;
  final String resellerId;
  final String supplierId;
  final String bundleId;
  final double platformFee;
  final String consumerId;
  final List<String>? productIds;
  final double totalPrice;
  final String status;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.resellerId,
    required this.supplierId,
    required this.bundleId,
    required this.platformFee,
    required this.consumerId,
    this.productIds,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });
}
