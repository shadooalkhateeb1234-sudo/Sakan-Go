import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/user_session_repository.dart';

class SetOnboardingCompletedUseCase
{
  final UserSessionRepository userSessionRepository;

  SetOnboardingCompletedUseCase({required this.userSessionRepository});

  Future<Either<Failure, Unit>> call() async
  {
    return await userSessionRepository.setOnboardingCompleted();
  }
}