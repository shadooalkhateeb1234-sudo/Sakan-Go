part of 'rating_bloc.dart';


abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

class LoadApartmentRatingEvent extends RatingEvent {
  final int apartmentId;

  const LoadApartmentRatingEvent(this.apartmentId);

  @override
  List<Object> get props => [apartmentId];
}
class RefreshApartmentRatingEvent extends RatingEvent {
  final int apartmentId;

  const RefreshApartmentRatingEvent(this.apartmentId);

  @override
  List<Object> get props => [apartmentId];
}
