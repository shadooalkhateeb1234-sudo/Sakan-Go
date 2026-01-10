part of 'rating_bloc.dart';


abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final double average;

  const RatingLoaded(this.average);

  @override
  List<Object> get props => [average];
}

class RatingEmpty extends RatingState {}

class RatingError extends RatingState {
  final String message;

  const RatingError(this.message);

  @override
  List<Object> get props => [message];
}
