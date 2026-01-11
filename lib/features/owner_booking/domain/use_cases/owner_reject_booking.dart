import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/owner_booking_repository.dart';

class RejectBooking {
  final OwnerBookingRepository repo;
  RejectBooking(this.repo);

  Future<Either<Failure, Unit>> call(int id) => repo.rejectBooking(id);
}
