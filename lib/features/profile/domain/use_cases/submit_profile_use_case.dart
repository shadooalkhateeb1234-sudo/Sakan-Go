import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class SubmitProfileUseCase
{
  final ProfileRepository profileRepository;

  SubmitProfileUseCase({required this.profileRepository});

  Future<Either<Failure, Unit>> call({required ProfileEntity profileEntity}) async
  {
    return await profileRepository.submitProfile(profileEntity: profileEntity);
  }
}