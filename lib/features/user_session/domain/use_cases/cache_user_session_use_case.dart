import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_session_entity.dart';
import '../repositories/user_session_repository.dart';

class CacheUserSessionUseCase
{
  final UserSessionRepository userSessionRepository;

  CacheUserSessionUseCase({required this.userSessionRepository});

  Future<Either<Failure, Unit>> call(UserSessionEntity userSessionEntity) async
  {
    return await userSessionRepository.cacheUserSession(userSessionEntity);
  }
}