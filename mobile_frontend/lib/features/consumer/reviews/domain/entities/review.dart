class Review {
  final String orderId;
  final String productId;
  final String userId;
  final String resellerId;
  final double rating;
  final String comment;

  Review({
    required this.orderId,
    required this.productId,
    required this.userId,
    required this.resellerId,
    required this.rating,
    required this.comment,
  });
}

class ReviewResponse {
  final bool success;
  final String message;
  final dynamic data;

  ReviewResponse({
    required this.success,
    required this.message,
    this.data,
  });
}
