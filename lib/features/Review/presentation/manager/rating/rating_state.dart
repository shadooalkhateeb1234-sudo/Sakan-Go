part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();
}

class RatingInitial extends RatingState {
  @override
  List<Object> get props => [];
}
