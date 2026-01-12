import '../entities/apartment_rating_entity.dart';

abstract class ReviewRepository {

  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  });
  Future<ApartmentRatingEntity> getApartmentAverageRating(int apartmentId);

  void invalidate(int apartmentId);

}




