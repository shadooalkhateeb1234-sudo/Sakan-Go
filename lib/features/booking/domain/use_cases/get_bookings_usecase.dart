import 'package:dartz/dartz.dart';
import 'package:sakan_go/features/booking/domain/entities/booking_entity.dart';
import '../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';


class GetUserBookingsUsecase {
  final BookingRepository repository;

  GetUserBookingsUsecase(this.repository);

  Future<Either<Failure, List<BookingEntity>>> call() {
    return repository.getUserBookings();
  }
}

