
import '../repositories/owner_booking_repository.dart';

class RejectUpdateRequest {
  final OwnerBookingRepository repo;
  RejectUpdateRequest(this.repo);

  Future<void> call(int requestId) =>
      repo.rejectUpdateRequest(requestId);
}
