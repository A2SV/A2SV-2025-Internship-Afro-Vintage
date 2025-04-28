import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/core/usecases/usecase.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/repositories/review_repository.dart';

class AddReviewUseCase extends UseCase<ReviewResponse, AddReviewParams> {
  final ReviewRepository repository;

  AddReviewUseCase({required this.repository});

  @override
  Future<Either<Failure, ReviewResponse>> call(AddReviewParams params) async {
    return await repository.addReview(params.review); // Passes Review entity
  }
}

class AddReviewParams extends Equatable {
  final Review review;

  const AddReviewParams({required this.review});

  @override
  List<Object?> get props => [review];
}
