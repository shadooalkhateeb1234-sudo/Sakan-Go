import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../entities/owner_booking_entity.dart';

abstract class OwnerBookingRepository {
  Future<Either<Failure, List<OwnerBookingEntity>>> getOwnerBookings();
  Future<Either<Failure, Unit>> approveBooking(int bookingId);
  Future<Either<Failure, Unit>> rejectBooking(int bookingId);

  Future<Either<Failure, List<BookingUpdateRequestEntity>>> getUpdateRequests();
  Future<Either<Failure, Unit>> approveUpdateRequest(int requestId);
  Future<Either<Failure, Unit>> rejectUpdateRequest(int requestId);
}

