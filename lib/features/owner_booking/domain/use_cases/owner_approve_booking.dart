
import '../repositories/owner_booking_repository.dart';

class ApproveBooking {
  final OwnerBookingRepository repo;
  ApproveBooking(this.repo);

  Future<void> call(int id) => repo.approveBooking(id);
}