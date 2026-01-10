import 'package:dartz/dartz.dart';

import '../local/data_sources/user_session_local_data_source.dart';
import 'package:sakan_go_mobile_app/core/errors/exceptions.dart';
import '../../domain/repositories/user_session_repository.dart';
import 'package:sakan_go_mobile_app/core/errors/failures.dart';
import '../../domain/entities/user_session_entity.dart';
import '../local/models/user_session_model.dart';

class UserSessionRepositoryImpl implements UserSessionRepository
{
  final UserSessionLocalDataSource userSessionLocalDataSource;

  UserSessionRepositoryImpl({required this.userSessionLocalDataSource});

  @override
  Future<Either<Failure, Unit>> cacheUserSession(UserSessionEntity userSessionEntity) async
  {
    try
    {
      await userSessionLocalDataSource.cacheUserSession(UserSessionModel.fromEntity(userSessionEntity));
      return Right(unit);
    }
    on CacheException
    {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearUserSession() async
  {
    try
    {
      await userSessionLocalDataSource.clearUserSession();
      return Right(unit);
    }
    on CacheException
    {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserSessionEntity>> getUserSession() async
  {
      final userSession = await userSessionLocalDataSource.getUserSession();
      return Right(userSession);
  }

  @override
  Future<Either<Failure, Unit>> setOnboardingCompleted() async
  {
      await userSessionLocalDataSource.setOnboardingCompleted();
      return Right(unit);
  }
}