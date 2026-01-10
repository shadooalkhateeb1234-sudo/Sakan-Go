import 'package:bloc/bloc.dart';
import 'package:sakan_go/features/app_intro/presentation/bloc/splash/splash_decision.dart';
import 'package:sakan_go/features/app_intro/presentation/bloc/splash/splash_event.dart';
import 'package:sakan_go/features/app_intro/presentation/bloc/splash/splash_state.dart';
import '../../../../user_session/domain/use_cases/get_user_session_use_case.dart';
import '../../../../user_session/domain/entities/user_session_entity.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>
{
  final GetUserSessionUseCase getUserSessionUseCase;

  SplashBloc({required this.getUserSessionUseCase}) : super(SplashInitial())
  {
    on<GetUserSessionEvent>(_onGetUserSession);
  }

  Future<void> _onGetUserSession(GetUserSessionEvent event, Emitter<SplashState> emit) async
  {
    emit(SplashLoading());

    final errorOrNavigate = await getUserSessionUseCase();

    errorOrNavigate.fold
    (
      (failure)
      {
        emit(SplashError(message: "Splash Error"));
      },
      (userSession)
      {
        //debug
        print('User Session: $userSession');

        emit(SplashNavigate(splashDecision: _splashDecision(userSession)));
      },
    );
  }

  SplashDecision _splashDecision(UserSessionEntity userSessionEntity)
  {
    assert
    (
      !(userSessionEntity.cookie != null && userSessionEntity.token != null),
      'Invalid session: cookie and token cannot exist together'
    );
    if (!userSessionEntity.isOnboardingCompleted)
    {
      return SplashDecision.onboarding;
    }

    if ((userSessionEntity.phoneNumber == null || userSessionEntity.cookie == null) && userSessionEntity.token == null)
    {
      return SplashDecision.phoneNumber;
    }

    if (userSessionEntity.cookie != null && !userSessionEntity.isProfileCompleted)
    {
      return SplashDecision.completeProfile;
    }

    if (userSessionEntity.isProfileCompleted && userSessionEntity.userStatus != UserStatus.approved)
    {
      return SplashDecision.approval;
    }

    if (userSessionEntity.userStatus == UserStatus.approved && (userSessionEntity.userRole == UserRole.owner || userSessionEntity.userRole == UserRole.tenant))
    {
      return SplashDecision.home;
    }

    return SplashDecision.onboarding;
  }
}