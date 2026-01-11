import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../../domain/entities/owner_booking_entity.dart';
import '../../domain/repositories/owner_booking_repository.dart';
import '../data_sources/owner_booking_remote_data_source.dart';


class OwnerBookingRepositoryImpl implements OwnerBookingRepository {
  final OwnerBookingRemoteDataSource remote;
  final NetworkInfo networkInfo;

  OwnerBookingRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OwnerBookingEntity>>> getOwnerBookings() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final data = await remote.getOwnerBookings();
      return Right(data);
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ConflictException {
      return Left(ConflictFailure());
    } on UnprocessableEntityException {
      return Left(UnprocessableEntityFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> approveBooking(int bookingId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remote.approveBooking(bookingId);
      return Right(unit);
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on ConflictException {
      return Left(ConflictFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> rejectBooking(int bookingId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      await remote.rejectBooking(bookingId);
      return Right(unit);
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on ConflictException {
      return Left(ConflictFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, List<BookingUpdateRequestEntity>>> getUpdateRequests() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final data = await remote.getUpdateRequests();
      return Right(data);
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> approveUpdateRequest(int requestId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
        await remote.approveUpdateRequest(requestId);
      return Right(unit);
    }on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on ConflictException {
      return Left(ConflictFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> rejectUpdateRequest(int requestId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
    await remote.rejectUpdateRequest(requestId);
    return Right(unit);
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    } on ConflictException {
      return Left(ConflictFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (_) {
      return Left(UnexpectedFailure());
    }
  }
}
