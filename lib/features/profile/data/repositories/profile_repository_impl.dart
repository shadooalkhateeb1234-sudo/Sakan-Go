import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../remote/data_sources/profile_remote_data_source.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../remote/models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository
{
  final ProfileRemoteDataSource profileRemoteDataSource;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({required this.profileRemoteDataSource,required this.userSessionLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> showProfile() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final userSession = await userSessionLocalDataSource.getUserSession();
      if(userSession.token == null)
      {
        return Left(UnAuthorizedFailure());
      }
      final user = await profileRemoteDataSource.showProfile(token: userSession.token!);

      return Right(user);
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
  Future<Either<Failure, Unit>> submitProfile({required ProfileEntity profileEntity}) async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final profileModel = ProfileModel
      (
        firstName: profileEntity.firstName,
        lastName: profileEntity.lastName,
        birthDate: profileEntity.birthDate,
        personalImage: profileEntity.personalImage,
        idImage: profileEntity.idImage,
      );
      final userSession = await userSessionLocalDataSource.getUserSession();
      if(userSession.cookie == null)
      {
        return Left(UnAuthorizedFailure());
      }
      await profileRemoteDataSource.submitProfile(cookie: userSession.cookie!, profileModel: profileModel);

      return const Right(unit);
    }
    on UnprocessableEntityException catch (e)
    {
      return Left(UnprocessableEntityFailure());
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
  Future<Either<Failure, UserEntity>> updateProfile({required ProfileEntity profileEntity}) async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final profileModel = ProfileModel
      (
        firstName: profileEntity.firstName,
        lastName: profileEntity.lastName,
        birthDate: profileEntity.birthDate,
        personalImage: profileEntity.personalImage,
        idImage: profileEntity.idImage,
      );
      final userSession = await userSessionLocalDataSource.getUserSession();
      if(userSession.token == null)
      {
        return Left(UnAuthorizedFailure());
      }
      final user = await profileRemoteDataSource.updateProfile(token: userSession.token!, profileModel: profileModel);

      return Right(user);
    }
    on UnprocessableEntityException catch (e)
    {
      return Left(UnprocessableEntityFailure());
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