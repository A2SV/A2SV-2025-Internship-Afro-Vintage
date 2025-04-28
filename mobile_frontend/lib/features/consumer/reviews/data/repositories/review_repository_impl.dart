import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/exception.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/repositories/review_repository.dart';
import 'package:mobile_frontend/features/consumer/reviews/data/datasources/review_data_source.dart';
import 'package:mobile_frontend/features/consumer/reviews/data/models/review_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource reviewDataSource;

  ReviewRepositoryImpl({
    required this.reviewDataSource,
  });

  @override
  Future<Either<Failure, ReviewResponse>> addReview(Review review) async {
    try {
      // Convert the Review entity to ReviewModel
      final reviewModel = ReviewModel(
        orderId: review.orderId,
        productId: review.productId,
        userId: review.userId,
        resellerId: review.resellerId,
        rating: review.rating,
        comment: review.comment,
      );

      // Call the data source to add the review
      final message = await reviewDataSource.addReview(reviewModel);

      // Return a successful response
      return Right(ReviewResponse(success: true, message: message, data: null));
    } on ServerException {
      // Handle server exceptions
      return Left(ServerFailure());
    }
  }
}
