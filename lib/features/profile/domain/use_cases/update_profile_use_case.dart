import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sakan_go_mobile_app/features/profile/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/errors/failures.dart';

class UpdateProfileUseCase
{
  final ProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call({required ProfileEntity profileEntity}) async
  {
    return await profileRepository.updateProfile(profileEntity: profileEntity);
  }
}