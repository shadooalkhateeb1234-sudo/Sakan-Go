import '../../domain/entities/owner_booking_entity.dart';
import 'owner_booking_remote_data_source.dart';
import 'dart:async';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../../../../core/error/exceptions.dart';

class FakeOwnerBookingRemoteDataSource
    implements OwnerBookingRemoteDataSource {

  final List<OwnerBookingEntity> _bookings = [
    OwnerBookingEntity(
      id: 1,
      user_id: 10,
      apartment_id: 99,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
      totalPrice: 450000,
      status: 'pending',
    ),
    OwnerBookingEntity(
      id: 2,
      user_id: 11,
      apartment_id: 100,
      startDate: DateTime.now().add(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 7)),
      totalPrice: 600000,
      status: 'confirmed',
    ),
  ];

  final List<BookingUpdateRequestEntity> _updateRequests = [];

  @override
  Future<List<OwnerBookingEntity>> getOwnerBookings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_bookings);
  }

  @override
  Future<void> approveBooking(int bookingId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) throw NotFoundException();

    _bookings[index] = OwnerBookingEntity(
      id: _bookings[index].id,
      user_id: _bookings[index].user_id,
      apartment_id: _bookings[index].apartment_id,
      startDate: _bookings[index].startDate,
      endDate: _bookings[index].endDate,
      totalPrice: _bookings[index].totalPrice,
      status: 'confirmed',
    );
  }

  @override
  Future<void> rejectBooking(int bookingId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) throw NotFoundException();

    _bookings[index] = OwnerBookingEntity(
      id: _bookings[index].id,
      user_id: _bookings[index].user_id,
      apartment_id: _bookings[index].apartment_id,
      startDate: _bookings[index].startDate,
      endDate: _bookings[index].endDate,
      totalPrice: _bookings[index].totalPrice,
      status: 'rejected',
    );
  }

  @override
  Future<List<BookingUpdateRequestEntity>> getUpdateRequests() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.from(_updateRequests);
  }

  @override
  Future<void> approveUpdateRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> rejectUpdateRequest(int requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}