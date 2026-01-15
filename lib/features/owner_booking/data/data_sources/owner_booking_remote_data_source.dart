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
      'Authorization': 'Bearer ${session.token}',
    };
  }


  @override
  Future<List<OwnerBookingEntity>> getOwnerBookings() async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.OwnerBookingRequests),
      headers: await _headers(),
    );
    final body = json.decode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      return (body['data'] as List)
          .map((e) => OwnerBookingModel.fromJson(e))
          .toList();
    }
  
    throw ServerException();
  }

  @override
  Future<void> approveBooking(int bookingId) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.approveAbooke}/$bookingId'),
      headers: await _headers(),
    );

    _handleResponse(response);
  }


  @override
  Future<void> rejectBooking(int bookingId) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.rejectAbook}/$bookingId'),
      headers: await _headers(),
    );

    _handleResponse(response);
  }

  @override
  Future<List<BookingUpdateRequestEntity>> getUpdateRequests() async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.OwnerBookingUpdateRequests),
      headers: await _headers(),
    );

    final body = json.decode(response.body);

    if (response.statusCode == 200 && body['status'] == true) {
      return (body['data'] as List)
          .map((e) => BookingUpdateRequestModel.fromJson(e))
          .toList();
    }

    throw ServerException();
  }

  @override
  Future<void> approveUpdateRequest(int requestId) async {
    final response = await client.get(
      Uri.parse(
          '${ApiEndpoints.approveBookingUpdateRequest}/$requestId'),
      headers: await _headers(),
    );

    _handleResponse(response);
  }

  @override
  Future<void> rejectUpdateRequest(int requestId) async {
    final response = await client.get(
      Uri.parse(
          '${ApiEndpoints.rejectBookingUpdateRequest}/$requestId'),
      headers: await _headers(),
    );

    _handleResponse(response);
  }
}

Future<void> _handleResponse(http.Response response) async {
  final body = json.decode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) &&
      body['status'] == true) {
    return;
  }

  if (response.statusCode == 200 && body['status'] == false) {
    throw ConflictException();
  }

  switch (response.statusCode) {
    case 401:
      throw UnAuthorizedException();
    case 403:
      throw ForbiddenException();
    case 404:
      throw NotFoundException();
    case 422:
      throw UnprocessableEntityException();
    case 500:
      throw ServerException();
    default:
      throw UnexpectedException();
  }
}
