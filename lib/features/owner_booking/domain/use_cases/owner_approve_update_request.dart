import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/owner_booking_repository.dart';

class ApproveUpdateRequest {
  final OwnerBookingRepository repo;
  ApproveUpdateRequest(this.repo);

  Future<Either<Failure, Unit>> call(int requestId) =>
      repo.approveUpdateRequest(requestId);
}