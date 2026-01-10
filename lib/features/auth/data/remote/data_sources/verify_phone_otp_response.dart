import '../../../../user_session/domain/entities/user_session_entity.dart';

abstract class VerifyPhoneOtpResponse {}

class VerifyPhoneOtpOldUser extends VerifyPhoneOtpResponse
{
  final String token;
  final UserRole userRole;

  VerifyPhoneOtpOldUser({required this.token, required this.userRole});
}

class VerifyPhoneOtpNewUser extends VerifyPhoneOtpResponse
{
  final String phoneNumber;
  final String countryCode;
  final String cookie;

  VerifyPhoneOtpNewUser({required this.phoneNumber,required this.countryCode, required this.cookie});
}