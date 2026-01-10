import 'package:sakan_go_mobile_app/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity
{
  const AuthModel({required super.expiresIn, required super.resendAvailableAt});

  factory AuthModel.fromJson(Map<String, dynamic> json)
  {
    final expiresIn = json['expires_in'] ?? 600;
    final resendAvailableAtString = json['resend_available_at'];
    int resendAvailableAtSeconds = 0;

    if (resendAvailableAtString != null)
    {
      final resendAvailableAt = DateTime.parse(resendAvailableAtString).toUtc();
      resendAvailableAtSeconds = resendAvailableAt.difference(DateTime.now().toUtc()).inSeconds;
      if (resendAvailableAtSeconds < 0) resendAvailableAtSeconds = 0;
    }
    return AuthModel
    (
      expiresIn: expiresIn,
      resendAvailableAt: resendAvailableAtSeconds
    );
  }
}