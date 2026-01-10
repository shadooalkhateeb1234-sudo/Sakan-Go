import 'package:equatable/equatable.dart';
import 'package:sakan_go/features/app_intro/presentation/bloc/splash/splash_decision.dart';

abstract class SplashState extends Equatable
{
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigate extends SplashState
{
  final SplashDecision splashDecision ;

  const SplashNavigate({required this.splashDecision});

  @override
  List<Object?> get props => [splashDecision];
}

class SplashError extends SplashState
{
  final String message;

  const SplashError({required this.message});

  @override
  List<Object?> get props => [message];
}