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
  Future<List<OwnerBookingEntity>> getOwnerBookings() async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet');
    }
    return remote.getOwnerBookings();
  }

  @override
  Future<void> approveBooking(int bookingId) async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet');
    }
     await remote.approveBooking(bookingId);
  }


  @override
  Future<void> rejectBooking(int bookingId)async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet');
    }
    await remote.rejectBooking(bookingId);
  }



  @override
  Future<void> approveUpdateRequest(int requestId) async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet');
    }
    remote.approveUpdateRequest(requestId);
  }
  @override
  Future<void> rejectUpdateRequest(int requestId) async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet');
    }
    await remote.rejectUpdateRequest(requestId);
}

  @override
  Future<List<BookingUpdateRequestEntity>> getUpdateRequests() async {
      if (!await networkInfo.isConnected) {
        throw Exception('No internet');
      }
     return await remote.getUpdateRequests();
    }


}
