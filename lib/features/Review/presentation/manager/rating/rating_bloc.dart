import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/review_repositpry_impl.dart';
import '../../../domain/use_cases/get_apartment_average_rating_usecase.dart';
part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetApartmentAverageRatingUseCase useCase;
  final ReviewRepositoryImpl repository;

  RatingBloc({required this.useCase,required this.repository})
      : super(RatingInitial()) {

    on<LoadApartmentRatingEvent>(_onLoad);
    on<RefreshApartmentRatingEvent>(_onRefresh);
  }

  Future<void> _onLoad(
      LoadApartmentRatingEvent event, Emitter emit) async {
    emit(RatingLoading());
    try {
      final rating = await useCase(event.apartmentId);
      emit(RatingLoaded(rating.averageRating));
    } catch (_) {
      emit(const RatingError('Failed to load rating'));
    }
  }

  Future<void> _onRefresh(
      RefreshApartmentRatingEvent event, Emitter emit) async {
    repository.invalidate(event.apartmentId);
    emit(RatingLoading());
    add(LoadApartmentRatingEvent(event.apartmentId));
  }
}
