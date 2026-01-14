import 'package:sakan_go/features/booking/domain/entities/payment_method.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../models/booking_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getUserBookings();
  Future<Unit> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required PaymentMethod paymentMethod,
  });
  Future<Unit> cancelBooking(int booking_id);
  Future<Unit> updateBooking({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required PaymentMethod paymentMethod,
  });
  Future<Unit> rejectBooking(int booking_id);

}
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  BookingRemoteDataSourceImpl({
    required this.client,
    required this.userSessionLocalDataSource,
  });

  Future<Map<String, String>> _headers() async {
  //  String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3VzZXIvdmVyaWZ5LXBob25lLW90cCIsImlhdCI6MTc2ODIzODAxMiwiZXhwIjoxNzY4ODQyODEyLCJuYmYiOjE3NjgyMzgwMTIsImp0aSI6Ijc2WHhEN1RHTXFlZDE2dm4iLCJzdWIiOiIxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.cawtsQLlg4IOpJGKVOGXhj5mMQsSCyr8isat0YLXdDk';

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
  Future<List<BookingModel>> getUserBookings() async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.showUserBookings),
      headers: await _headers(),
    );

    final body = json.decode(response.body);

    if (body['status'] != true) return [];

    return (body['data'] as List)
        .map((e) => BookingModel.fromJson(e))
        .toList();
  }

  @override
  Future<Unit> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required PaymentMethod paymentMethod,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiEndpoints.bookAnApartment}/$apartment_id'),
      headers: await _headers(),
      body: jsonEncode({
        "start_date": start_date.toIso8601String().split('T').first,
        "end_date": end_date.toIso8601String().split('T').first,
        "location": {
          "lat": latitude,
          "lng": longitude,
        },
        "payment_method": paymentMethod.value,
      }),
    );

    return _handleResponse(response);
  }

  @override
  Future<Unit> cancelBooking(int booking_id) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.cancelAbook}/$booking_id'),
      headers: await _headers(),
    );

    return _handleResponse(response);
  }

  @override
  Future<Unit> updateBooking({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required PaymentMethod paymentMethod,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiEndpoints.updateBooking}/$booking_id'),
      headers: await _headers(),
      body: jsonEncode({
        'update_start_date': startDate.toIso8601String().split('T').first,
        'update_end_date': endDate.toIso8601String().split('T').first,
        'payment_method': paymentMethod.value,

      }),
    );

    return _handleResponse(response);
  }
  @override
  Future<Unit> rejectBooking(int booking_id) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.rejectAbook}/$booking_id'),
      headers: await _headers(),
    );

    return _handleResponse(response);
  }

}

Unit _handleResponse(http.Response response) {
  if (response.body.isEmpty) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    }
    throw ServerFailure();
  }

  final body = json.decode(response.body);

  switch (response.statusCode) {
    case 200:
    case 201:
      if (body['status'] == true) return unit;
      throw BookingFailure(body['message'] ?? 'Unknown error');

    case 401:
      throw UnAuthorizedFailure();
    case 404:
      throw NotFoundFailure();
    case 409:
      throw ConflictFailure();
    case 422:
      throw UnprocessableEntityFailure();
    case 500:
      throw ServerFailure();
    default:
      throw UnexpectedFailure();
  }
}
