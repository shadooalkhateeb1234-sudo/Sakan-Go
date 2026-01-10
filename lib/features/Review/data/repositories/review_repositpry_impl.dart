import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../domain/entities/apartment_rating_entity.dart';
import '../../domain/repositories/review_repository.dart';
import '../data_sources/review_remote_data_source.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remote;
  final NetworkInfo networkInfo;
  final UserSessionLocalDataSource userSessionLocalDataSource;

  ReviewRepositoryImpl({
    required this.remote,
    required this.networkInfo,
    required this.userSessionLocalDataSource,
  });

  @override
  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  }) async {
    if (!await networkInfo.isConnected) {
      throw NetworkFailure();
    }

    await remote.createReview(
      booking_id: booking_id,
      stars: stars,
      comment: comment,
    );
  }

  final Map<int, ApartmentRatingEntity> _cache = {};

  @override
  Future<ApartmentRatingEntity> getApartmentAverageRating(int apartmentId) async {
    if (!await networkInfo.isConnected) {
      throw NetworkFailure();
    }
    if (_cache.containsKey(apartmentId)) {
      return _cache[apartmentId]!;
    }

    final avg = await remote.getApartmentAverageRating(apartmentId);
    final rating = ApartmentRatingEntity(averageRating: avg);
    _cache[apartmentId] = rating;
    return rating;
  }

  void invalidate(int apartmentId) {
    _cache.remove(apartmentId);
  }
}
