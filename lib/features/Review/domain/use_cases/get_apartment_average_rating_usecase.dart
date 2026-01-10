import '../entities/apartment_rating_entity.dart';
import '../repositories/review_repository.dart';

class GetApartmentAverageRatingUseCase {
  final ReviewRepository repository;

  GetApartmentAverageRatingUseCase(this.repository);

  Future<ApartmentRatingEntity> call(int apartmentId) {
    return repository.getApartmentAverageRating(apartmentId);
  }
}

