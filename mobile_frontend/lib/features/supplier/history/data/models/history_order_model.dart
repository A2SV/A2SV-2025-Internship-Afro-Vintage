class HistoryOrderModel {
  final String id;
  final String resellerId;
  final String supplierId;
  final String bundleId;
  final double platformFee;
  final String consumerId;
  final double totalPrice;
  final String status;
  final String createdAt;
  final String resellerUsername;

  HistoryOrderModel({
    required this.id,
    required this.resellerId,
    required this.supplierId,
    required this.bundleId,
    required this.platformFee,
    required this.consumerId,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.resellerUsername,
  });

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) {
    final order = json['order'] ?? {};
    return HistoryOrderModel(
      id: order['id'] ?? '',
      resellerId: order['reseller_id'] ?? '',
      supplierId: order['supplier_id'] ?? '',
      bundleId: order['bundle_id'] ?? '',
      platformFee: (order['platform_fee'] as num?)?.toDouble() ?? 0.0,
      consumerId: order['consumer_id'] ?? '',
      totalPrice: (order['total_price'] as num?)?.toDouble() ?? 0.0,
      status: order['status'] ?? '',
      createdAt: order['created_at'] ?? '',
      resellerUsername: json['resellerUsername'] ?? '',
    );
  }
} 