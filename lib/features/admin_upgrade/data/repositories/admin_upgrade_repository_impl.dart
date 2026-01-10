import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/admin_upgrade/data/remote/data_sources/admin_upgrade_remote_data_source.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../../user_session/data/local/models/user_session_model.dart';
import '../../../user_session/domain/entities/user_session_entity.dart';
import '../../domain/entities/admin_upgrade_entity.dart';
import '../../domain/repositories/admin_upgrade_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

class AdminUpgradeRepositoryImpl implements AdminUpgradeRepository
{
  final AdminUpgradeRemoteDataSource adminUpgradeRemoteDataSource;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  final NetworkInfo networkInfo;

  AdminUpgradeRepositoryImpl({required this.adminUpgradeRemoteDataSource, required this.userSessionLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, AdminUpgradeEntity>> checkAdminUpgrade() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final userSession = await userSessionLocalDataSource.getUserSession();
      if (userSession.token == null)
      {
        return Left(UnAuthorizedFailure());
      }
      final response = await adminUpgradeRemoteDataSource.checkAdminUpgrade(userSession.token!);

      UserSessionEntity updateUserSession = userSession.copyWith
      (
        userRole: response.upgradeStatus == UpgradeStatus.approved ? UserRole.owner : UserRole.tenant
      );

      await userSessionLocalDataSource.cacheUserSession(UserSessionModel.fromEntity(updateUserSession));

      return Right(response);
    }
    on UnAuthorizedException
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

  @override
  Future<Either<Failure, Unit>> submitUpgrade() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final userSession = await userSessionLocalDataSource.getUserSession();
      if (userSession.token == null)
      {
        return Left(UnAuthorizedFailure());
      }
      await adminUpgradeRemoteDataSource.submitUpgrade(userSession.token!);

      return Right(unit);
    }
    on UnAuthorizedException
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