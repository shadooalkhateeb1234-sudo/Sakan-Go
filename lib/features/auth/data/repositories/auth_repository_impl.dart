import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/data/local/data_sources/user_session_local_data_source.dart';
import '../../../user_session/data/local/models/user_session_model.dart';
import '../../../user_session/domain/entities/user_session_entity.dart';
import '../../domain/entities/auth_entity.dart';
import '../remote/data_sources/verify_phone_otp_response.dart';
import '../remote/data_sources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository
{
  final AuthRemoteDataSource authRemoteDataSource;
  final UserSessionLocalDataSource userSessionLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.networkInfo, required this.userSessionLocalDataSource});

  @override
  Future<Either<Failure, AuthEntity>> sendPhoneOtp(String phoneNumber, String countryCode) async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final result = await authRemoteDataSource.sendPhoneOtp(phoneNumber, countryCode);

      return Right(result);
    }
    on UnprocessableEntityException
    {
      return Left(UnprocessableEntityFailure());
    }
    on TooManyRequestException
    {
      return Left(TooManyRequestFailure());
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
    catch (_)
    {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> resendPhoneOtp(String phoneNumber, String countryCode) async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final result = await authRemoteDataSource.resendPhoneOtp(phoneNumber, countryCode);

      return Right(result);
    }
    on TooManyRequestException
    {
      return Left(TooManyRequestFailure());
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
    catch (_)
    {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, UserSessionEntity>> verifyPhoneOtp(String phoneNumber, String countryCode, String otp) async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final response = await authRemoteDataSource.verifyPhoneOtp(phoneNumber, countryCode, otp);
      final currentSession = await userSessionLocalDataSource.getUserSession();
      late UserSessionEntity updateUserSession;
      if (response is VerifyPhoneOtpOldUser)
      {
        updateUserSession = currentSession.copyWith
        (
          phoneNumber: phoneNumber,
          cookie: null,
          token: response.token,
          isOnboardingCompleted: true,
          isProfileCompleted: true,
          userStatus: UserStatus.approved,
          userRole: response.userRole
        );
      }
      else if (response is VerifyPhoneOtpNewUser)
      {
        updateUserSession = currentSession.copyWith
        (
          phoneNumber: response.phoneNumber,
          cookie: response.cookie,
          token: null
        );
      }
      await userSessionLocalDataSource.cacheUserSession(UserSessionModel.fromEntity(updateUserSession));

      return Right(updateUserSession);
    }
    on UnprocessableEntityException
    {
      return Left(UnprocessableEntityFailure());
    }
    on GoneException
    {
      return Left(GoneFailure());
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
    on UnexpectedException
    {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final session = await userSessionLocalDataSource.getUserSession();
      final token = session.token;

      if (token != null)
      {
        await authRemoteDataSource.logout(token);
      }

      await userSessionLocalDataSource.clearUserSession();

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

  @override
  Future<Either<Failure, Unit>> refreshToken() async
  {
    if (!await networkInfo.isConnected)
    {
      return Left(OfflineFailure());
    }
    try
    {
      final session = await userSessionLocalDataSource.getUserSession();
      final token = session.token;
      if (token == null) return Left(UnAuthorizedFailure());

      final response = await authRemoteDataSource.refreshToken(token);
      final updatedSession = session.copyWith(token: response.token, tokenExpiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)));

      await userSessionLocalDataSource.cacheUserSession(UserSessionModel.fromEntity(updatedSession));
      return const Right(unit);
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