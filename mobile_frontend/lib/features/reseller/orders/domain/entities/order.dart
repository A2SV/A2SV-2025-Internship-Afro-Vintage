class OrderItem {
  final String id;
  final String bundleId;
  final String resellerId;
  final String supplierId;
  final double totalPrice;
  final String status; // e.g., 'pending', 'processing', 'shipped', 'delivered', 'cancelled'
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String? trackingNumber;
  final String shippingAddress;
  final Map<String, dynamic> bundleSnapshot; // Snapshot of bundle at time of order
  final String paymentStatus; // e.g., 'pending', 'paid', 'failed'
  final String paymentMethod;

  OrderItem({
    required this.id,
    required this.bundleId,
    required this.resellerId,
    required this.supplierId,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
    this.trackingNumber,
    required this.shippingAddress,
    required this.bundleSnapshot,
    required this.paymentStatus,
    required this.paymentMethod,
  });
}