import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sakan_go_mobile_app/features/profile/data/remote/models/profile_model.dart';
import 'package:sakan_go_mobile_app/features/profile/data/remote/models/user_model.dart';
import '../../../../../core/network/http_status_codes.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class ProfileRemoteDataSource
{
  Future<UserModel> showProfile({required String token});

  Future<void> submitProfile({required String cookie, required ProfileModel profileModel});

  Future<UserModel> updateProfile({required String token, required ProfileModel profileModel});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource
{
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> showProfile({required String token}) async
  {
    final response = await client.get
    (
      Uri.parse(ApiEndpoints.showProfile),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Authorization': 'Bearer $token'
      }
    );

    final body = jsonDecode(response.body);

    switch (response.statusCode)
    {
      case HttpStatusCodes.ok:
        return UserModel.fromJson(body['user']);
      case HttpStatusCodes.notFound:
        throw NotFoundException();
      case HttpStatusCodes.forbidden:
        throw ForbiddenException();
      case HttpStatusCodes.internalServerError:
        throw ServerException();
      case HttpStatusCodes.unauthorized:
        throw UnAuthorizedException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<void> submitProfile({required String cookie, required ProfileModel profileModel}) async
  {
    final request = http.MultipartRequest
    (
      'POST',
       Uri.parse(ApiEndpoints.submitProfile)
    );
    request.headers.addAll
    ({
      'Accept': 'application/json',
      'Accept-Language': 'en',
      'Authorization': 'Bearer $cookie',
    });
    request.fields.addAll
    ({
      'first_name': profileModel.firstName!,
      'last_name': profileModel.lastName!,
      'birth_date': profileModel.birthDate!.toIso8601String(),
    });
    request.files.add
    (
      await http.MultipartFile.fromPath
      (
        'personal_image',
         profileModel.personalImage!
      ),
    );
    request.files.add
    (
      await http.MultipartFile.fromPath
      (
        'id_image',
         profileModel.idImage!
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final body = jsonDecode(responseBody);

    switch (response.statusCode)
    {
      case HttpStatusCodes.created:
        return;
      case HttpStatusCodes.unprocessableEntity:
        throw UnprocessableEntityException();
      case HttpStatusCodes.notFound:
        throw NotFoundException();
      case HttpStatusCodes.forbidden:
        throw ForbiddenException();
      case HttpStatusCodes.internalServerError:
        throw ServerException();
      case HttpStatusCodes.unauthorized:
        throw UnAuthorizedException();
      default:
        throw UnexpectedException();
    }
  }

  @override
  Future<UserModel> updateProfile({required String token, required ProfileModel profileModel}) async
  {
    final request = http.MultipartRequest
    (
      'POST',
       Uri.parse(ApiEndpoints.updateProfile)
    );
    request.headers.addAll
    ({
      'Accept': 'application/json',
      'Accept-Language': 'en',
      'Authorization': 'Bearer $token',
    });
    if (profileModel.firstName != null)
    {
      request.fields['first_name'] = profileModel.firstName!;
    }
    if (profileModel.lastName != null)
    {
      request.fields['last_name'] = profileModel.lastName!;
    }
    if (profileModel.birthDate != null)
    {
      request.fields['birth_date'] = profileModel.birthDate!.toIso8601String();
    }
    if (profileModel.personalImage != null && profileModel.personalImage!.isNotEmpty && !profileModel.personalImage!.startsWith('http'))
    {
      request.files.add
      (
        await http.MultipartFile.fromPath
        (
          'personal_image',
          profileModel.personalImage!
        ),
      );
    }
    if (profileModel.idImage != null && profileModel.idImage!.isNotEmpty && !profileModel.idImage!.startsWith('http'))
    {
      request.files.add
      (
        await http.MultipartFile.fromPath
        (
          'id_image',
          profileModel.idImage!,
        ),
      );
    }
    if (request.fields.isEmpty && request.files.isEmpty)
    {
      throw UnprocessableEntityException();
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final body = jsonDecode(responseBody);

    switch (response.statusCode)
    {
      case HttpStatusCodes.ok:
        return UserModel.fromJson(body['user']);
      case HttpStatusCodes.unauthorized:
        throw UnAuthorizedException();
      case HttpStatusCodes.unprocessableEntity:
        throw UnprocessableEntityException();
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