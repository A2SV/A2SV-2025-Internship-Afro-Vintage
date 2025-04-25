import '../../domain/entities/order.dart';

class OrderModel extends OrderItem {
  OrderModel({
    required String id,
    required String bundleId,
    required String resellerId,
    required String supplierId,
    required double totalPrice,
    required String status,
    required DateTime orderDate,
    DateTime? deliveryDate,
    String? trackingNumber,
    required String shippingAddress,
    required Map<String, dynamic> bundleSnapshot,
    required String paymentStatus,
    required String paymentMethod,
  }) : super(
          id: id,
          bundleId: bundleId,
          resellerId: resellerId,
          supplierId: supplierId,
          totalPrice: totalPrice,
          status: status,
          orderDate: orderDate,
          deliveryDate: deliveryDate,
          trackingNumber: trackingNumber,
          shippingAddress: shippingAddress,
          bundleSnapshot: bundleSnapshot,
          paymentStatus: paymentStatus,
          paymentMethod: paymentMethod,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      bundleId: json['bundle_id'],
      resellerId: json['reseller_id'],
      supplierId: json['supplier_id'],
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
      deliveryDate: json['delivery_date'] != null 
          ? DateTime.parse(json['delivery_date']) 
          : null,
      trackingNumber: json['tracking_number'],
      shippingAddress: json['shipping_address'],
      bundleSnapshot: json['bundle_snapshot'],
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bundle_id': bundleId,
      'reseller_id': resellerId,
      'supplier_id': supplierId,
      'total_price': totalPrice,
      'status': status,
      'order_date': orderDate.toIso8601String(),
      'delivery_date': deliveryDate?.toIso8601String(),
      'tracking_number': trackingNumber,
      'shipping_address': shippingAddress,
      'bundle_snapshot': bundleSnapshot,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
    };
  }
}