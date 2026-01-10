import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_entity.dart';

class SendPhoneOtpUseCase
{
  final AuthRepository authRepository;

  SendPhoneOtpUseCase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({required String phoneNumber, required String countryCode}) async
  {
    return await authRepository.sendPhoneOtp(phoneNumber, countryCode);
  }
}