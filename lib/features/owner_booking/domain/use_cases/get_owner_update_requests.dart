import '../repositories/owner_booking_repository.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';

class GetOwnerUpdateRequests {
  final OwnerBookingRepository repo;
  GetOwnerUpdateRequests(this.repo);

  Future<List<BookingUpdateRequestEntity>> call() =>
      repo.getUpdateRequests();
}
