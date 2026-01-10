import 'package:dartz/dartz.dart';

import 'package:sakan_go_mobile_app/features/profile/domain/entities/profile_entity.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/errors/failures.dart';

class SubmitProfileUseCase
{
  final ProfileRepository profileRepository;

  SubmitProfileUseCase({required this.profileRepository});

  Future<Either<Failure, Unit>> call({required ProfileEntity profileEntity}) async
  {
    return await profileRepository.submitProfile(profileEntity: profileEntity);
  }
}