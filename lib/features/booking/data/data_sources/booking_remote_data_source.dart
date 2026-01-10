import '../../../../core/network/api_endpoints.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../models/booking_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/booking_update_request_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getUserBookings();
  Future<Unit> bookApartment({
    required int apartment_id,
    required DateTime start_date,
    required DateTime end_date,
    required double latitude,
    required double longitude,
    required String paymentMethod,
  });
  Future<Unit> cancelBooking(int booking_id);
  ///  OWNER REJECT
  Future<Unit> rejectBooking(int booking_id);

  Future<List<BookingUpdateRequestModel>> requestBookingUpdate({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentMethod,
  });
  // Future<Unit> updateBooking({
  //   required int booking_id,
  //   required DateTime newStart,
  //   required DateTime newEnd,
  //   required String paymentMethod,
  // });

}
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  final UserSessionLocalDataSource userSessionLocalDataSource;

  BookingRemoteDataSourceImpl({
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
      'Authorization': 'Bearer ${session.token}', // ✅ FIXED
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
    required String paymentMethod,
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
        "payment_method": paymentMethod,
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
  Future<Unit> rejectBooking(int booking_id) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.rejectAbook}/$booking_id'),
      headers: await _headers(),
    );

    return _handleResponse(response);
  }

  @override
  Future<List<BookingUpdateRequestModel>> requestBookingUpdate({
    required int booking_id,
    required DateTime startDate,
    required DateTime endDate,
    required String paymentMethod,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiEndpoints.updateBooking}/$booking_id'),
      headers: await _headers(),
      body: jsonEncode({
        'update_start_date': startDate.toIso8601String().split('T').first,
        'update_end_date': endDate.toIso8601String().split('T').first,
        'payment_method': paymentMethod,
      }),
    );

    final body = json.decode(response.body);

    if (response.statusCode == 201) {
      return (body['data'] as List)
          .map((e) => BookingUpdateRequestModel.fromJson(e))
          .toList();
    }

    if (response.statusCode == 409) throw ConflictFailure();
    if (response.statusCode == 422) throw UnprocessableEntityFailure();

    throw ServerFailure();
  }

  // @override
  // Future<Unit> updateBooking({
  //   required int booking_id,
  //   required DateTime newStart,
  //   required DateTime newEnd,
  //   required String paymentMethod,
  // }) async {
  //   final response = await client.post(
  //     Uri.parse('${ApiEndpoints.updateBooking}/$booking_id'),
  //     headers: await _headers(),
  //     body: jsonEncode({
  //       'start_date': newStart.toIso8601String().split('T').first,
  //       'end_date': newEnd.toIso8601String().split('T').first,
  //       'payment_method': paymentMethod,
  //     }),
  //   );
  //
  //   return _handleResponse(response);
  // }

}

Unit _handleResponse(http.Response response) {
  final body = json.decode(response.body);

  switch (response.statusCode) {
    case 200:
      if (body['status'] == true) return unit ;
      throw BookingFailure();

    case 401:
      throw UnAuthorizedFailure();

    case 403:
      throw ForbiddenFailure();

    case 404:
      throw NotFoundFailure();

    case 409:
      throw ConflictFailure();

    case 422:
      throw UnprocessableEntityFailure();

    case 429:
      throw TooManyRequestFailure();

    case 410:
      throw GoneFailure();

    case 500:
      throw ServerFailure();

    default:
      throw UnexpectedFailure();
  }
}



//
// class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
//   final http.Client client;
//   final UserSessionLocalDataSource userSessionLocalDataSource;
//
//   ///this must be delete later
//   static const String  _token = '';
//
//   BookingRemoteDataSourceImpl({
//     required this.client,
//     required this.userSessionLocalDataSource,
//   });
//
//   Future<Map<String, String>> _headers() async {
//     final session = await userSessionLocalDataSource.getUserSession();
//     if (session.token == null || session.token!.isEmpty) {
//       throw UnAuthorizedFailure();
//     }
//     return {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${session.token}',
//     };
//   }
//   @override
//   Future<List<BookingModel>> getUserBookings() async {
//     final response = await client.get(
//       Uri.parse( ApiEndpoints.showUserBookings),
//       headers: await _headers(),
//     );
//
//     final body = json.decode(response.body);
//
//     if (body['status'] == false) return [];
//
//     return (body['data'] as List)
//         .map((e) => BookingModel.fromJson(e))
//         .toList();
//   }
//
//   @override
//   Future<Unit> bookApartment({
//     required int apartment_id,
//     required DateTime start_date,
//     required DateTime end_date,
//     required double latitude,
//     required double longitude,
//     required String paymentMethod,
//   }) async {
//     final response = await client.post(
//       Uri.parse('${ApiEndpoints.bookAnApartment}/$apartment_id' ),
//       headers: await _headers(),
//       body: json.encode({
//         "start_date": start_date.toIso8601String(),
//         "end_date": end_date.toIso8601String(),
//         "location": {
//           "lat": latitude,
//           "lng": longitude,
//         },
//         "payment_method": paymentMethod,
//       }),
//     );
//     return _handleResponse(response);
//   }
//
//   @override
//   Future<Unit> cancelBooking(int booking_id) async {
//     final response = await client.get(
//       Uri.parse('${ApiEndpoints.cancelAbook}/$booking_id'),
//       headers: await _headers(),
//     );
//     return _handleResponse(response);
//   }
//
//   @override
//   Future<Unit> rejectBooking(int booking_id) async {
//     final response = await client.get(
//       Uri.parse( '${ApiEndpoints.rejectAbook}/$booking_id'),
//       headers: await _headers(),
//     );
//     return _handleResponse(response);
//   }
//
//   @override
//   Future<List<BookingUpdateRequestModel>> requestBookingUpdate({
//     required int booking_id,
//     required DateTime startDate,
//     required DateTime endDate,
//   }) async {
//
//     final response = await client.post(
//       Uri.parse('${ApiEndpoints.requestupdateBooking}/$booking_id'),
//       headers: await _headers(),
//       body: jsonEncode({
//         'update_start_date': startDate.toIso8601String().split('T').first,
//         'update_end_date': endDate.toIso8601String().split('T').first,
//       }),
//     );
//     final body = json.decode(response.body);
//
//
//     if (response.statusCode == 201) {
//       return (body['data'] as List).map((e) =>
//           BookingUpdateRequestModel.fromJson(e)).toList();
//      }
//
//     if (response.statusCode == 404) {
//       throw  ServerFailure();
//     }
//
//     if (response.statusCode == 409) {
//       throw ConflictFailure();
//     }
//
//     if (response.statusCode == 422) {
//       throw UnprocessableEntityFailure();
//     }
//
//     throw ServerException();
//   }
//   }
//
//
