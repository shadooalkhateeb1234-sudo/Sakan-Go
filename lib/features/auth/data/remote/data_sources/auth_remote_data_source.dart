import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sakan_go_mobile_app/features/auth/data/remote/data_sources/verify_phone_otp_response.dart';
import 'package:sakan_go_mobile_app/features/auth/data/remote/models/refresh_token_model.dart';
import '../../../../../core/network/http_status_codes.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource
{
  Future<AuthModel> sendPhoneOtp(String phoneNumber, String countryCode);

  Future<AuthModel> resendPhoneOtp(String phoneNumber, String countryCode);

  Future<VerifyPhoneOtpResponse> verifyPhoneOtp(String phoneNumber, String countryCode, String otp);

  Future<void> logout(String token);

  Future<RefreshTokenModel> refreshToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource
{
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthModel> sendPhoneOtp(String phoneNumber, String countryCode) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.sendPhoneOtp),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'country_code': countryCode, 'phone_number' :phoneNumber})
    );
    final body = jsonDecode(response.body);

    switch (response.statusCode)
    {
      case HttpStatusCodes.ok:
        return AuthModel.fromJson(body['data']);
      case HttpStatusCodes.unprocessableEntity:
        throw UnprocessableEntityException();
      case HttpStatusCodes.tooManyRequest:
        throw TooManyRequestException();
      case HttpStatusCodes.notFound:
        throw ForbiddenException();
      case HttpStatusCodes.internalServerError:
        throw NotFoundException();
      case HttpStatusCodes.forbidden:
        throw ServerException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<AuthModel> resendPhoneOtp(String phoneNumber, String countryCode) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.resendPhoneOtp),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'phone_number': phoneNumber, 'country_code': countryCode}),
    );
    final body = jsonDecode(response.body);

    switch (response.statusCode)
    {
      case HttpStatusCodes.ok:
        return AuthModel.fromJson(body['data']);
      case HttpStatusCodes.tooManyRequest:
        throw TooManyRequestException();
      case HttpStatusCodes.forbidden:
        throw ForbiddenException();
      case HttpStatusCodes.notFound:
        throw NotFoundException();
      case HttpStatusCodes.internalServerError:
        throw ServerException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<VerifyPhoneOtpResponse> verifyPhoneOtp(String phoneNumber, String countryCode, String otp) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.verifyPhoneOtp),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'phone_number': phoneNumber, 'country_code': countryCode, 'otp': otp})
    );

    switch (response.statusCode)
    {
      case HttpStatusCodes.ok:
      {
          final data = jsonDecode(response.body)['data'];
          if (data.containsKey('token'))
          {
            return VerifyPhoneOtpOldUser(token: data['token'], userRole: data['user_role']);
          }
          else
          {
            return VerifyPhoneOtpNewUser(phoneNumber: data['phone_number'],countryCode: data['country_code'],cookie: data['cookie']);
          }
      }
      case HttpStatusCodes.unprocessableEntity:
        throw UnprocessableEntityException();
      case HttpStatusCodes.gone:
        throw GoneException();
      case HttpStatusCodes.forbidden:
        throw ForbiddenException();
      case HttpStatusCodes.notFound:
        throw NotFoundException();
      case HttpStatusCodes.internalServerError:
        throw ServerException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<void> logout(String token) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.logout),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Authorization': 'Bearer $token'
      }
    );
    switch(response.statusCode)
    {
      case HttpStatusCodes.ok:
      case HttpStatusCodes.unauthorized:
        return;
      case HttpStatusCodes.forbidden:
        throw ForbiddenException();
      case HttpStatusCodes.notFound:
        throw NotFoundException();
      case HttpStatusCodes.internalServerError:
        throw ServerException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<RefreshTokenModel> refreshToken(String token) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.refreshToken),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Authorization': 'Bearer $token'
      }
    );

    switch(response.statusCode)
    {
       case HttpStatusCodes.ok:
         return RefreshTokenModel.fromJson(jsonDecode(response.body));
       case HttpStatusCodes.unauthorized:
         throw UnAuthorizedException();
       case HttpStatusCodes.forbidden:
         throw ForbiddenException();
       case HttpStatusCodes.notFound:
         throw NotFoundException();
       case HttpStatusCodes.internalServerError:
         throw ServerException();
       default:
         throw UnexpectedException();
    }
  }
}