import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class AddReviewEvent extends ReviewEvent {
  final Review review;

  const AddReviewEvent({required this.review});

  @override
  List<Object?> get props => [review];
}
