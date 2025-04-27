import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/pages/add_review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, ReviewResponse>> addReview(Review review);
}
