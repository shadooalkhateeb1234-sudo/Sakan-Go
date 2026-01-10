import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/use_cases/create_review_usecase.dart';
import '../../domain/use_cases/get_apartment_average_rating_usecase.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final CreateReviewUseCase createReviewUseCase;
  final GetApartmentAverageRatingUseCase getApartmentAverageRatinguseCase;
  ReviewBloc(this.createReviewUseCase, this.getApartmentAverageRatinguseCase) : super(ReviewInitial()) {

    on<CreateReviewEvent>((event, emit) async {
      emit(ReviewLoading());

      try {
        await createReviewUseCase(
          booking_id: event.booking_id,
          stars: event.stars,
          comment: event.comment,
        );

        emit(ReviewSuccess('Review created successfully'));
      } on Failure catch (failure) {
        emit(ReviewError(failure.message));
      } catch (_) {
        emit(ReviewError('Unexpected error'));
      }
    });

  //   void load(int apartmentId) async {
  //       try {
  //         final rating = await getApartmentAverageRatinguseCase(
  //             apartmentId
  //         );
  //         emit(rating as ReviewState);
  //       }on Failure catch (failure) {
  //         emit(ReviewError(failure.message));
  //       }catch (_) {
  //         emit(ReviewError('Unexpected error'));
  //       }
   }

}
//.......

