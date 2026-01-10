import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_entity.dart';

class ResendPhoneOtpUseCase
{
  final AuthRepository authRepository;

  ResendPhoneOtpUseCase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({required String phoneNumber, required String countryCode}) async
  {
    return await authRepository.resendPhoneOtp(phoneNumber, countryCode);
  }
}