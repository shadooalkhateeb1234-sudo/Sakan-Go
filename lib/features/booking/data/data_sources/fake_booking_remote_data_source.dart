import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/booking_model.dart';
import '../models/booking_update_request_model.dart';
import 'booking_remote_data_source.dart';

 
class FakeBookingRemoteDataSource implements BookingRemoteDataSource {

  final List<BookingModel> _bookings = [
    BookingModel(
      id: 1,
      user_id: 1,
      apartment_id: 1,
      start_date: DateTime(2026, 1, 1),
      end_date: DateTime(2026, 1, 5),
      total_price: 500,
      status: 'completed',
    ),
    BookingModel(
      id: 2,
      user_id: 1,
      apartment_id: 2,
      start_date: DateTime(2026, 2, 10),
      end_date: DateTime(2026, 2, 15),
      total_price: 1200,
      status: 'pending',
    ),
  ];

  final List<BookingUpdateRequestModel> _updateRequests = [];

  int _bookingIdCounter = 3;
  int _updateRequestCounter = 1;

  // ============================
  // 📋 USER BOOKINGS
  // ============================
  @override
  Future<List<BookingModel>> getUserBookings() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_bookings);
  }

  // ============================
  // ➕ CREATE BOOKING
  // ============================
  @override
  Future<Unit> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required String paymentMethod,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (end_date.isBefore(start_date)) {
      throw UnprocessableEntityFailure();
    }

    // ❗ simulate conflict (409)
    final conflict = _bookings.any((b) =>
    b.apartment_id == apartment_id &&
        b.status != 'cancelled' &&
        b.status != 'rejected' &&
        !(end_date.isBefore(b.start_date) || start_date.isAfter(b.end_date))
    );

    if (conflict) {
      throw ConflictFailure();
    }

    _bookings.add(
      BookingModel(
        id: _bookingIdCounter++,
        user_id: 1,
        apartment_id: apartment_id,
        start_date: start_date,
        end_date: end_date,
        total_price:
        (end_date.difference(start_date).inDays + 1) * 100,
        status: 'pending', // 🔑 always pending
      ),
    );

    return unit;
  }

  // ============================
  // ❌ CANCEL BOOKING
  // ============================
  @override
  Future<Unit> cancelBooking(int booking_id) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _bookings.indexWhere((b) => b.id == booking_id);
    if (index == -1) throw NotFoundFailure();

    if (_bookings[index].status == 'cancelled' ||
        _bookings[index].status == 'rejected') {
      throw ConflictFailure();
    }

    _bookings[index] =
        _bookings[index].copyWith(status: 'cancelled');

    return unit;
  }

  // ============================
  // ✏️ REQUEST UPDATE (pending approval)
  // ============================
  @override
  Future<List<BookingUpdateRequestModel>> requestBookingUpdate({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentMethod,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final booking =
    _bookings.firstWhere((b) => b.id == booking_id,
        orElse: () => throw NotFoundFailure());

    if (booking.status != 'confirmed') {
      throw ConflictFailure();
    }

    // conflict with other bookings
    final conflict = _bookings.any((b) =>
    b.apartment_id == booking.apartment_id &&
        b.id != booking_id &&
        !(startDate.isBefore(b.start_date) ||
            endDate.isAfter(b.end_date)));

    if (conflict) {
      throw ConflictFailure();
    }

    _updateRequests.add(
      BookingUpdateRequestModel(
        id: _updateRequestCounter++,
        booking_id: booking_id,
        status: 'pending',
        update_start_date: startDate,
        update_end_date: endDate,

      ),
    );

    return  [_updateRequests.last];
  }

  // ============================
  // 📋 USER UPDATE REQUESTS
  // ============================
  @override
  Future<List<BookingUpdateRequestModel>>
  getUserBookingUpdateRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_updateRequests);
  }

  // ============================
  // 🛑 CANCEL UPDATE REQUEST
  // ============================
  @override
  Future<Unit> cancelBookingUpdateRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final index =
    _updateRequests.indexWhere((r) => r.id == requestId);

    if (index == -1) throw NotFoundFailure();

    _updateRequests[index] =
        _updateRequests[index].copyWith(status: 'cancelled');

    return unit;
  }

  @override
  Future<Unit> rejectBooking(int booking_id) {
    // TODO: implement rejectBooking
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateBooking({required int booking_id, required DateTime newStart, required DateTime newEnd, required String paymentMethod}) {
    // TODO: implement updateBooking
    throw UnimplementedError();
  }


}
