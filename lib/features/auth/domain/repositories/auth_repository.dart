import 'package:dartz/dartz.dart';

import '../../../user_session/domain/entities/user_session_entity.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository
{
  Future<Either<Failure, AuthEntity>> sendPhoneOtp(String phoneNumber, String countryCode);

  Future<Either<Failure, AuthEntity>> resendPhoneOtp(String phoneNumber, String countryCode);

  Future<Either<Failure, UserSessionEntity>> verifyPhoneOtp(String phoneNumber, String countryCode, String otp);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> refreshToken();
}