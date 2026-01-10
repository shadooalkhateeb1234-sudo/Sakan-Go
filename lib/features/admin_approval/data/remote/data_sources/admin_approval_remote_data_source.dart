import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sakan_go_mobile_app/features/admin_approval/data/remote/models/admin_approval_model.dart';
import 'package:sakan_go_mobile_app/core/network/http_status_codes.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class AdminApprovalRemoteDataSource
{
  Future<AdminApprovalModel> checkAdminApproval(String cookie);
}

class AdminApprovalRemoteDataSourceImpl implements AdminApprovalRemoteDataSource
{
  final http.Client client;

  AdminApprovalRemoteDataSourceImpl({required this.client});

  @override
  Future<AdminApprovalModel> checkAdminApproval(String cookie) async
  {
    final response = await client.get
    (
      Uri.parse(ApiEndpoints.adminApproval),
      headers:
      {
        'Accept': 'application/json',
        'Accept-Language': 'en',
        'Authorization': 'Bearer $cookie'
      }
    );
    final data = jsonDecode(response.body)['data'];

    switch(response.statusCode)
    {
      case HttpStatusCodes.ok:
        return AdminApprovalModel.fromJson(data);
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