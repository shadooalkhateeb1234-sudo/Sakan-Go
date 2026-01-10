import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository repository;

  CreateBookingUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required String paymentMethod,
  }) {
    return repository.bookApartment(
      apartment_id: apartment_id,
      start_date: start_date,
      end_date: end_date,
      latitude: latitude,
      longitude: longitude,
      paymentMethod: paymentMethod,
    );
  }
}



