import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable
{
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent
{
  final String phoneNumber;
  final String countryCode;

  const SendOtpEvent({required this.phoneNumber, required this.countryCode});

  @override
  List<Object?> get props => [phoneNumber, countryCode];
}

class ResendOtpEvent extends AuthEvent
{
  final String phoneNumber;
  final String countryCode;

  const ResendOtpEvent({required this.phoneNumber, required this.countryCode});

  @override
  List<Object?> get props => [phoneNumber, countryCode];
}

class VerifyOtpEvent extends AuthEvent
{
  final String phoneNumber;
  final String countryCode;
  final String otp;

  const VerifyOtpEvent({required this.phoneNumber, required this.countryCode, required this.otp});

  @override
  List<Object?> get props => [phoneNumber, countryCode, otp];
}

class LogoutEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}