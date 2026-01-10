import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../entities/user_entity.dart';

abstract class ProfileRepository
{
  Future<Either<Failure, UserEntity>> showProfile();

  Future<Either<Failure, Unit>> submitProfile({required ProfileEntity profileEntity});

  Future<Either<Failure, UserEntity>> updateProfile({required ProfileEntity profileEntity});
}