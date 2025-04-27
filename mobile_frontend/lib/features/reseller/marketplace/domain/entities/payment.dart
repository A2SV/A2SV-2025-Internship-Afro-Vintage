class Payment {
  final String id;
  final String fromUserId;
  final String toUserId;
  final double amount;
  final double platformFee;
  final double sellerEarning;
  final String status;
  final String referenceId;
  final String type;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.amount,
    required this.platformFee,
    required this.sellerEarning,
    required this.status,
    required this.referenceId,
    required this.type,
    required this.createdAt,
  });
} 