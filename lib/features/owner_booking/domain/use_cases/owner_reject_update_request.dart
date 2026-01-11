import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/owner_booking_repository.dart';

class RejectUpdateRequest {
  final OwnerBookingRepository repo;
  RejectUpdateRequest(this.repo);

  Future<Either<Failure, Unit>> call(int requestId) =>
      repo.rejectUpdateRequest(requestId);
}
