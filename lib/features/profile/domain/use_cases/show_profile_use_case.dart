import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/profile/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/errors/failures.dart';

class ShowProfileUseCase
{
  final ProfileRepository profileRepository;

  ShowProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call() async
  {
    return await profileRepository.showProfile();
  }
}