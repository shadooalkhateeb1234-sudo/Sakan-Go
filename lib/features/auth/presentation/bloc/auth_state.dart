import '../../../user_session/domain/entities/user_session_entity.dart';
import '../../domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable
{
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSentSuccess extends AuthState
{
  final AuthEntity auth;

  const OtpSentSuccess({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class OtpVerifiedSuccess extends AuthState
{
  final UserSessionEntity session;

  const OtpVerifiedSuccess({required this.session});

  @override
  List<Object?> get props => [session];
}

class AuthValidationError extends AuthState
{
  final Map<String, List<String>> fieldErrors;

  const AuthValidationError({required this.fieldErrors});

  @override
  List<Object?> get props => [fieldErrors];
}

class OtpBlocked extends AuthState
{
  final double resendAfterSeconds;

  const OtpBlocked({required this.resendAfterSeconds});

  @override
  List<Object?> get props => [resendAfterSeconds];
}

class OtpInvalid extends AuthState {}

class OtpExpired extends AuthState {}

class AuthActionSuccess extends AuthState {}

class AuthFailureState extends AuthState
{
  final String message;

  const AuthFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}