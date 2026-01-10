import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/http_status_codes.dart';
import '../models/admin_upgrade_model.dart';

abstract class AdminUpgradeRemoteDataSource
{
  Future<AdminUpgradeModel> checkAdminUpgrade(String token);

  Future<void> submitUpgrade(String token);
}

class AdminUpgradeRemoteDataSourceImpl implements AdminUpgradeRemoteDataSource
{
  final http.Client client;

  AdminUpgradeRemoteDataSourceImpl({required this.client});

  @override
  Future<AdminUpgradeModel> checkAdminUpgrade(String token) async
  {
    final response = await client.get
    (
      Uri.parse(ApiEndpoints.checkAdminUpgrade),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Authorization': 'Bearer $token'
      }
    );
    final data = jsonDecode(response.body)['data'];

    switch(response.statusCode)
    {
      case HttpStatusCodes.ok:
        return AdminUpgradeModel.fromJson(data);
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

  @override
  Future<void> submitUpgrade(String token) async
  {
    final response = await client.post
    (
      Uri.parse(ApiEndpoints.requestAdminUpgrade),
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
        return;
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