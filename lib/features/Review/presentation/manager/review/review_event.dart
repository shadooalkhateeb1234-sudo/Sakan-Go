part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class CreateReviewEvent extends ReviewEvent {
  final int booking_id;
  final int stars;
  final String? comment;

  CreateReviewEvent({
    required this.booking_id,
    required this.stars,
    this.comment,
  });

  @override
   List<Object?> get props =>  [booking_id,stars,comment];
}
