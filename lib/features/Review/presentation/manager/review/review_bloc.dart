import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/use_cases/create_review_usecase.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final CreateReviewUseCase createReview;

  ReviewBloc({required this.createReview})
      : super(ReviewInitial()) {
    on<CreateReviewEvent>(_onCreate);
  }

  Future<void> _onCreate(
      CreateReviewEvent event,
      Emitter<ReviewState> emit,
      ) async {
    emit(ReviewLoading());

    try {
      await createReview(
        booking_id: event.booking_id,
        stars: event.stars,
        comment: event.comment,
      );
      emit(  ReviewSuccess('review_created_success'));
    } on Failure catch (f) {
      emit(ReviewError(f.message));
    } catch (_) {
      emit(  ReviewError('unexpected_error'));
    }
  }
}
