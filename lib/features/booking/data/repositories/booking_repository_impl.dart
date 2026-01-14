import 'package:dartz/dartz.dart';
import 'package:sakan_go/features/booking/domain/entities/booking_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/booking_repository.dart';
import '../data_sources/booking_remote_data_source.dart';


class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remote;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remote,
    required this.userSessionLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BookingEntity>>> getUserBookings() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final data = await remote.getUserBookings();
      return Right(data);
    } on Failure catch (e) {
      return Left(e);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required PaymentMethod paymentMethod,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remote.bookApartment(
        apartment_id: apartment_id,
        start_date: start_date,
        end_date: end_date,
        latitude: latitude,
        longitude: longitude,
        paymentMethod: paymentMethod,
      );
      return Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelBooking(int booking_id) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remote.cancelBooking(booking_id);
      return Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBooking({
      required int booking_id,
      required DateTime startDate,
      required DateTime endDate,
      required PaymentMethod paymentMethod,
}  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      await remote.updateBooking(
        booking_id: booking_id,
        startDate: startDate,
        endDate: endDate,
        paymentMethod: paymentMethod,
      );
      return Right(unit);
    } on Failure catch (e) {
      return Left(e);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, Unit>> rejectBooking(int booking_id) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remote.rejectBooking(booking_id);
      return Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

}
