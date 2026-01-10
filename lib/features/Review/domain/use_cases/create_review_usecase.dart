import '../repositories/review_repository.dart';

class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase(this.repository);

  Future<void> call({
    required int booking_id,
    required int stars,
    String? comment,
  }) async {
    await repository.createReview(
      booking_id: booking_id,
      stars: stars,
      comment: comment,
    );
  }
}
