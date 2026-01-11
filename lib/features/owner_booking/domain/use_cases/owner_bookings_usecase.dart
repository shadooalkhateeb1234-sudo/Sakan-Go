import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/owner_booking_entity.dart';
import '../repositories/owner_booking_repository.dart';

class GetOwnerBookings {
  final OwnerBookingRepository repo;
  GetOwnerBookings(this.repo);

  Future<Either<Failure, List<OwnerBookingEntity>>> call() => repo.getOwnerBookings();
}