import 'package:dartz/dartz.dart';
import 'package:sakan_go/features/booking/domain/entities/payment_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getUserBookings();
  Future<Either<Failure, Unit>> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double longitude,
    required double latitude,
    required PaymentEntity paymentMethod,
  });
  Future<Either<Failure, Unit>> cancelBooking(int booking_id);
  Future<Either<Failure, Unit>> updateBooking({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required PaymentEntity paymentMethod,
  });
  Future<Either<Failure, Unit>> createReview({
    required int bookingId,
    required int stars,
    String? comment,
  });
  Future<Either<Failure, Unit>> rejectBooking(int booking_id);

}
