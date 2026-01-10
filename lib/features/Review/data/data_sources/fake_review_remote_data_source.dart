import 'package:sakan_go/features/Review/data/data_sources/review_remote_data_source.dart';

import '../../../booking/data/data_sources/fake_booking_remote_data_source.dart';

class FakeReviewRemoteDataSource implements ReviewRemoteDataSource {
  final FakeBookingRemoteDataSource bookingSource;

  FakeReviewRemoteDataSource(this.bookingSource);

  @override
  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

   // bookingSource.markAsRated(booking_id);
  }

  final Map<int, List<int>> _ratings = {
    10: [4, 5],
  };

  @override
  Future<double> getApartmentAverageRating(int apartmentId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final list = _ratings[apartmentId] ?? [];
    if (list.isEmpty) return 0;

    return list.reduce((a, b) => a + b) / list.length;
  }

  void addRating(int apartmentId, int stars) {
    _ratings.putIfAbsent(apartmentId, () => []);
    _ratings[apartmentId]!.add(stars);
  }
}

