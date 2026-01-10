import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase
{
  final ProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call({required ProfileEntity profileEntity}) async
  {
    return await profileRepository.updateProfile(profileEntity: profileEntity);
  }
}