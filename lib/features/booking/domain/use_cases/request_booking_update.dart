import 'package:dartz/dartz.dart';
import 'package:sakan_go/features/booking/domain/entities/payment_entity.dart';
import '../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';

class UpdateBookingUseCase {
  final BookingRepository repository;

  UpdateBookingUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required PaymentEntity paymentMethod,
  } ) {
    return repository.updateBooking(
        booking_id:booking_id ,
        startDate: startDate,
        endDate: endDate,
        paymentMethod: paymentMethod,
    );
  }
}
