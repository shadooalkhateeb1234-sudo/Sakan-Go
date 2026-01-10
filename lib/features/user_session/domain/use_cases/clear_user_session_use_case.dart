import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_session_repository.dart';

class ClearUserSessionUseCase
{
  final UserSessionRepository userSessionRepository;

  ClearUserSessionUseCase({required this.userSessionRepository});

  Future<Either<Failure, Unit>> call() async
  {
    return await userSessionRepository.clearUserSession();
  }
}