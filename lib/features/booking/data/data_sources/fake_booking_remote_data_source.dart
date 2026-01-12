import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/booking_model.dart';
import '../models/booking_update_request_model.dart';
import 'booking_remote_data_source.dart';
import '../../domain/entities/booking_entity.dart';
import 'booking_remote_data_source.dart';

 import 'dart:async';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/booking_model.dart';
import '../models/booking_update_request_model.dart';
import 'booking_remote_data_source.dart';

class FakeBookingRemoteDataSource implements BookingRemoteDataSource {

final List<BookingModel> _bookings = [];

@override
Future<List<BookingModel>> getUserBookings() async {
await Future.delayed(const Duration(milliseconds: 400));
return List.from(_bookings);
}

@override
Future<Unit> bookApartment({
required int apartment_id,
required DateTime start_date,
required DateTime end_date,
required double latitude,
required double longitude,
required String paymentMethod,
}) async {
await Future.delayed(const Duration(milliseconds: 500));

/// simulate conflict
if (start_date.isAfter(end_date)) {
throw ConflictFailure();
}

_bookings.add(
BookingModel(
  id: _bookings.length + 1,
  apartment_id: apartment_id,
  start_date: start_date,
  end_date: end_date,
  status: 'pending',
  user_id: 1,
  total_price: 1000,

),
);

return unit;
}

@override
Future<Unit> cancelBooking(int booking_id) async {
await Future.delayed(const Duration(milliseconds: 300));

final index = _bookings.indexWhere((b) => b.id == booking_id);
if (index == -1) throw NotFoundFailure();

_bookings[index] = _bookings[index].copyWith(status: 'cancelled');
return unit;
}

@override
Future<Unit> rejectBooking(int booking_id) async {
await Future.delayed(const Duration(milliseconds: 300));

final index = _bookings.indexWhere((b) => b.id == booking_id);
if (index == -1) throw NotFoundFailure();

_bookings[index] = _bookings[index].copyWith(status: 'rejected');
return unit;
}

@override
Future<List<BookingUpdateRequestModel>> requestBookingUpdate({
required int booking_id,
required DateTime startDate,
required DateTime endDate,
required String paymentMethod,
}) async {
await Future.delayed(const Duration(milliseconds: 400));

if (startDate.isAfter(endDate)) {
throw UnprocessableEntityFailure();
}

return [
BookingUpdateRequestModel(
  id: 1,
  booking_id: booking_id,
  update_start_date: startDate,
  update_end_date: endDate,
  status: 'pending',
),
];
}
}
