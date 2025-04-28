import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/usecases/add_review.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_event.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final AddReviewUseCase addReviewUseCase;

  ReviewBloc({required this.addReviewUseCase}) : super(const ReviewEmpty()) {
    on<AddReviewEvent>(_onAddReview);
  }

  Future<void> _onAddReview(
      AddReviewEvent event, Emitter<ReviewState> emit) async {
    emit(const ReviewLoading());

    final result =
        await addReviewUseCase(AddReviewParams(review: event.review));

    result.fold(
      (failure) => emit(ReviewError(message: _mapFailureToMessage(failure))),
      (response) => emit(ReviewSuccess(
        message: response.message,
        response: response,
      )),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map different failure types to user-friendly messages
    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else {
      return 'Unexpected error occurred.';
    }
  }
}
