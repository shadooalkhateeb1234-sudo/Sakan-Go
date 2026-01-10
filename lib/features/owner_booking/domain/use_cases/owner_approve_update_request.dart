import '../repositories/owner_booking_repository.dart';

class ApproveUpdateRequest {
  final OwnerBookingRepository repo;
  ApproveUpdateRequest(this.repo);

  Future<void> call(int requestId) =>
      repo.approveUpdateRequest(requestId);
}