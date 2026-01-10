import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/user_session/domain/entities/user_session_entity.dart';
import '../repositories/user_session_repository.dart';
import '../../../../core/errors/failures.dart';

class CacheUserSessionUseCase
{
  final UserSessionRepository userSessionRepository;

  CacheUserSessionUseCase({required this.userSessionRepository});

  Future<Either<Failure, Unit>> call(UserSessionEntity userSessionEntity) async
  {
    return await userSessionRepository.cacheUserSession(userSessionEntity);
  }
}