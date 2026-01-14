import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/booking_entity.dart';
import '../entities/payment_method.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getUserBookings();
  Future<Either<Failure, Unit>> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double longitude,
    required double latitude,
    required PaymentMethod paymentMethod,
  });
  Future<Either<Failure, Unit>> cancelBooking(int booking_id);
  Future<Either<Failure, Unit>> updateBooking({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required PaymentMethod paymentMethod,
  });

  Future<Either<Failure, Unit>> rejectBooking(int booking_id);

}
