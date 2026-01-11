
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/owner_booking_repository.dart';

class ApproveBooking {
  final OwnerBookingRepository repo;
  ApproveBooking(this.repo);

  Future<Either<Failure, Unit>> call(int id) => repo.approveBooking(id);
}