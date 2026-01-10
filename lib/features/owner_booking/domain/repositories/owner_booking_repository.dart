
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../entities/owner_booking_entity.dart';

abstract class OwnerBookingRepository {
  Future<List<OwnerBookingEntity>> getOwnerBookings();
  Future<void> approveBooking(int bookingId);
  Future<void> rejectBooking(int bookingId);

  Future<List<BookingUpdateRequestEntity>> getUpdateRequests();
  Future<void> approveUpdateRequest(int requestId);
  Future<void> rejectUpdateRequest(int requestId);
}
