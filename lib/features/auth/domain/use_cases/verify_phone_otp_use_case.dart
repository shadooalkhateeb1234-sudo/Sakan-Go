import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../user_session/domain/entities/user_session_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyPhoneOtpUseCase
{
  final AuthRepository authRepository;

  VerifyPhoneOtpUseCase({required this.authRepository});

  Future<Either<Failure, UserSessionEntity>> call({required String phoneNumber, required String countryCode, required String otp}) async
  {
    return await authRepository.verifyPhoneOtp(phoneNumber, countryCode, otp);
  }
}