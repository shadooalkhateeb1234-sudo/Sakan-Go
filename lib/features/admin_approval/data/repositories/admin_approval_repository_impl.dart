import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../../user_session/data/local/models/user_session_model.dart';
import '../../../user_session/domain/entities/user_session_entity.dart';
import '../../domain/entities/admin_approval_entity.dart';
import '../../domain/repositories/admin_approval_repository.dart';
import '../../../../core/network/network_info.dart';
import '../remote/data_sources/admin_approval_remote_data_source.dart';

class AdminApprovalRepositoryImpl implements AdminApprovalRepository
{
  final AdminApprovalRemoteDataSource adminApprovalRemoteDataSource;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  final NetworkInfo networkInfo;

  AdminApprovalRepositoryImpl({required this.adminApprovalRemoteDataSource, required this.userSessionLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, AdminApprovalEntity>> checkAdminApproval() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final userSession = await userSessionLocalDataSource.getUserSession();
      if (userSession.cookie == null)
      {
        return Left(UnAuthorizedFailure());
      }
      final response = await adminApprovalRemoteDataSource.checkAdminApproval(userSession.cookie!);

      UserSessionEntity updateUserSession = userSession.copyWith
      (
        cookie: response.token != null ? null : userSession.cookie,
        token: response.token ?? userSession.token,
        userStatus: response.userStatus
      );

      await userSessionLocalDataSource.cacheUserSession(UserSessionModel.fromEntity(updateUserSession));

      return Right(response);
    }
    on UnAuthorizedFailure
    {
      return Left(UnAuthorizedFailure());
    }
    on ForbiddenException
    {
      return Left(ForbiddenFailure());
    }
    on NotFoundException
    {
      return Left(NotFoundFailure());
    }
    on ServerException
    {
      return Left(ServerFailure());
    }
    on CacheException
    {
      return Left(CacheFailure());
    }
    catch (_)
    {
      return Left(UnexpectedFailure());
    }
  }
}