import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';


abstract class ReviewRemoteDataSource {
  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  });

  Future<double> getApartmentAverageRating(int apartmentId);
}
class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final http.Client client;
  final UserSessionLocalDataSource userSessionLocalDataSource;

  ReviewRemoteDataSourceImpl({
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
  Future<double> getApartmentAverageRating(int apartmentId) async {
    final response = await client.get(
      Uri.parse('${ApiEndpoints.apartmentAverageRating}/$apartmentId'),
      headers: await _headers(),
    );

    final body = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        return (body['data']['average_rating'] as num).toDouble();
      case 404:
        throw NotFoundFailure();
      default:
        throw ServerFailure();
    }
  }


  @override
  Future<void> createReview({
    required int booking_id,
    required int stars,
    String? comment,
  }) async {
    final response = await client.post(
      Uri.parse('${ApiEndpoints.review}/$booking_id'),
      headers: await _headers(),
      body: jsonEncode({
        'stars': stars,
        if (comment != null) 'comment': comment,
      }),
    );

    switch (response.statusCode) {
      case 201:
        return;

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

      case 500:
        throw ServerFailure();

      default:
        throw UnexpectedFailure();
    }
  }
}
