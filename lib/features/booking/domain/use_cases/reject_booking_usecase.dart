import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';

class RejectBookingUseCase {
  final BookingRepository repository;

  RejectBookingUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int bookingId) {
    return repository.rejectBooking(bookingId);
  }
}
