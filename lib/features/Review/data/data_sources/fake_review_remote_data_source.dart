import 'package:sakan_go/features/Review/data/data_sources/review_remote_data_source.dart';
import '../../../../core/error/failures.dart';


class FakeReviewRemoteDataSource implements ReviewRemoteDataSource {

  double? _averageRating;

  @override
  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (stars < 1 || stars > 5) {
      throw UnprocessableEntityFailure();
    }

    _averageRating = stars.toDouble();
  }

  @override
  Future<double> getApartmentAverageRating(int apartmentId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_averageRating == null) {
      throw EmptyFailure();
    }

    return _averageRating!;
  }
}
// class FakeReviewRemoteDataSource implements ReviewRemoteDataSource {
//   final Map<int, double> _ratings = {};
//   final Set<int> _reviewedBookings = {};
//
//   @override
//   Future<void> createReview({
//     required int booking_id,
//     required int stars,
//     String? comment,
//   }) async {
//     await Future.delayed(const Duration(milliseconds: 600));
//
//     if (_reviewedBookings.contains(booking_id)) {
//       throw Exception('review_already_exists');
//     }
//
//     _reviewedBookings.add(booking_id);
//
//     // fake: كل bookingId تابع لشقة رقم 99
//     _ratings[99] = stars.toDouble();
//   }
//
//   @override
//   Future<double> getApartmentAverageRating(int apartmentId) async {
//     await Future.delayed(const Duration(milliseconds: 400));
//     return _ratings[apartmentId] ?? 4.2;
//   }
// }
