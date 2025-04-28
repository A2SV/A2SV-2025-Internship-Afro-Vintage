import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required String orderId,
    required String productId,
    required String userId,
    required String resellerId,
    required double rating,
    required String comment,
  }) : super(
          orderId: orderId,
          productId: productId,
          userId: userId,
          resellerId: resellerId,
          rating: rating,
          comment: comment,
        );

  // Factory constructor to create a ReviewModel from a map (e.g., JSON)
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      orderId: map['orderId'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      resellerId: map['resellerId'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      comment: map['comment'] as String? ?? '',
    );
  }

  // Method to convert a ReviewModel to a map (e.g., for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId.isNotEmpty ? orderId : null,
      'product_id': productId.isNotEmpty ? productId : null,
      'user_id': userId.isNotEmpty ? userId : null,
      'reseller_id': resellerId.isNotEmpty ? resellerId : null,
      'rating': rating > 0 ? rating : null,
      'comment': comment.isNotEmpty ? comment : null,
    };
  }
}
