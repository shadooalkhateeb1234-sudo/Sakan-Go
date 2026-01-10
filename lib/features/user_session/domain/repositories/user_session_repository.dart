import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_session_entity.dart';

abstract class UserSessionRepository
{
  Future<Either<Failure, Unit>> cacheUserSession(UserSessionEntity userSessionEntity);

  Future<Either<Failure, Unit>> clearUserSession();

  Future<Either<Failure, UserSessionEntity>> getUserSession();

  Future<Either<Failure, Unit>> setOnboardingCompleted();
}