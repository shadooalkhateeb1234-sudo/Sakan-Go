import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/repositories/review_repository.dart';
import '../../../domain/use_cases/get_apartment_average_rating_usecase.dart';
part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetApartmentAverageRatingUseCase getRating;
  final ReviewRepository repository;

  RatingBloc({
    required this.getRating,
    required this.repository,
  }) : super(RatingInitial()) {
    on<LoadApartmentRatingEvent>(_onLoad);
    on<RefreshApartmentRatingEvent>(_onRefresh);
  }

  Future<void> _onLoad(
      LoadApartmentRatingEvent event,
      Emitter<RatingState> emit,
      ) async {
    emit(RatingLoading());
    try {
      final rating = await getRating(event.apartmentId);
      emit(RatingLoaded(rating.averageRating));
    } on Failure catch (f) {
      emit(RatingError(f.message));
    } catch (_) {
      emit(const RatingError('unexpected_error'));
    }
  }

  Future<void> _onRefresh(
      RefreshApartmentRatingEvent event,
      Emitter<RatingState> emit,
      ) async {
    repository.invalidate(event.apartmentId);
    add(LoadApartmentRatingEvent(event.apartmentId));
  }
}
