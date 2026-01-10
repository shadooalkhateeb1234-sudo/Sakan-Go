import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_session_repository.dart';
import '../entities/user_session_entity.dart';

class GetUserSessionUseCase
{
  final UserSessionRepository userSessionRepository;

  GetUserSessionUseCase({required this.userSessionRepository});

  Future<Either<Failure, UserSessionEntity>> call() async
  {
    return await userSessionRepository.getUserSession();
  }
}