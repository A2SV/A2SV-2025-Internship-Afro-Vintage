import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

class ReviewEmpty extends ReviewState {
  const ReviewEmpty();
}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewLoaded({required this.reviews});

  @override
  List<Object?> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReviewSuccess extends ReviewState {
  final String message;
  final ReviewResponse response;

  const ReviewSuccess({required this.message, required this.response});

  @override
  List<Object?> get props => [message, response];
}
