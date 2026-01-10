import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_update_request_entity.dart';
import '../repositories/booking_repository.dart';

class RequestBookingUpdateUseCase {
  final BookingRepository repository;

  RequestBookingUpdateUseCase(this.repository);

  Future<Either<Failure, List<BookingUpdateRequestEntity>>> call({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentMethod,
  } ) {
    return repository.requestBookingUpdate(
        booking_id:booking_id ,
        startDate: startDate,
        endDate: endDate,
        paymentMethod: paymentMethod,
    );
  }
}
