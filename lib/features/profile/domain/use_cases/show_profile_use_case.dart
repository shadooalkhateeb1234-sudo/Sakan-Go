import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class ShowProfileUseCase
{
  final ProfileRepository profileRepository;

  ShowProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call() async
  {
    return await profileRepository.showProfile();
  }
}