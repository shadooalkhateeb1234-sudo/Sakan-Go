import 'package:dartz/dartz.dart';

import '../repositories/user_session_repository.dart';
import '../../../../core/errors/failures.dart';

class SetOnboardingCompletedUseCase
{
  final UserSessionRepository userSessionRepository;

  SetOnboardingCompletedUseCase({required this.userSessionRepository});

  Future<Either<Failure, Unit>> call() async
  {
    return await userSessionRepository.setOnboardingCompleted();
  }
}