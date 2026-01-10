import '../repositories/owner_booking_repository.dart';

class RejectBooking {
  final OwnerBookingRepository repo;
  RejectBooking(this.repo);

  Future<void> call(int id) => repo.rejectBooking(id);
}
