import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../booking/data/models/booking_update_request_model.dart';
import '../../../booking/domain/entities/booking_update_request_entity.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../domain/entities/owner_booking_entity.dart';
import '../models/owner_booking_model.dart';

abstract class OwnerBookingRemoteDataSource {
  Future<List<OwnerBookingEntity>> getOwnerBookings();
  Future<void> approveBooking(int bookingId);
  Future<void> rejectBooking(int bookingId);

  Future<List<BookingUpdateRequestEntity>> getUpdateRequests();
  Future<void> approveUpdateRequest(int requestId);
  Future<void> rejectUpdateRequest(int requestId);
}
class OwnerBookingRemoteDataSourceImpl implements OwnerBookingRemoteDataSource {

  final http.Client client;
  final UserSessionLocalDataSource userSessionLocalDataSource;

  OwnerBookingRemoteDataSourceImpl({
    required this.client,
    required this.userSessionLocalDataSource,
   });

  Future<Map<String, String>> _headers() async {
    final session = await userSessionLocalDataSource.getUserSession();
    if (session.token == null || session.token!.isEmpty) {
      throw UnAuthorizedFailure();
    }
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${session.token}', // 'Bearer ${session.token}'
    };
  }

  @override
  Future<List<OwnerBookingEntity>> getOwnerBookings() async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.OwnerBookingRequests),
      headers: await _headers(),
    );

    final body = json.decode(response.body);

    if (response.statusCode == 200) {
      return (body['data'] as List)
          .map((e) => OwnerBookingModel.fromJson(e))
          .toList();
    }

    throw ServerException();
  }

  Future<void> approveBooking(int booking_id) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.approveAbooke}/$booking_id'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }


  @override
  Future<void> rejectBooking(int bookingId) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.rejectAbook}/$bookingId'),
      headers: await _headers(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<List<BookingUpdateRequestEntity>> getUpdateRequests() async {
    final response = await client.get(
      Uri.parse( ApiEndpoints.OwnerBookingUpdateRequests),
      headers: await _headers(),
    );

    final body = json.decode(response.body);

    return (body['data'] as List)
        .map((e) => BookingUpdateRequestModel.fromJson(e))
        .toList();
  }


  @override
  Future<void> approveUpdateRequest(int requestId) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.approveBookingUpdateRequest}/$requestId'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }


  @override
  Future<void> rejectUpdateRequest(int requestId) async {
    final response = await client.get(
      Uri.parse(
        '${ApiEndpoints.rejectBookingUpdateRequest}/$requestId',
      ),
      headers: await _headers(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
