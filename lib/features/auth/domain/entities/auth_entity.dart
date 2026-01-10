import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable
{
  final int expiresIn;
  final int resendAvailableAt;

  const AuthEntity({required this.expiresIn, required this.resendAvailableAt});

  @override
  String toString()
  {
    return '(expiresIn: $expiresIn, resendAfterSeconds: $resendAvailableAt)';
  }

  @override
  List<Object?> get props => [expiresIn, resendAvailableAt];
}