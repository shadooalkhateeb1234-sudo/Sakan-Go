part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {
  @override
   List<Object?> get props =>  [];
}

class ReviewSuccess extends ReviewState {
  final String message;
  ReviewSuccess(this.message);

  @override
   List<Object?> get props =>  [message];
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError(this.message);

  @override
   List<Object?> get props =>  [message];
}
