import 'package:bloc/bloc.dart';

import '../../../../user_session/domain/use_cases/set_onboarding_completed_use_case.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState>
{
  final SetOnboardingCompletedUseCase setOnboardingCompletedUseCase;

  OnboardingBloc({required this.setOnboardingCompletedUseCase,}) : super(OnboardingInitialState())
  {
    on<OnboardingCompletedEvent>(_onCompleteOnboarding);
  }

  Future<void> _onCompleteOnboarding(OnboardingCompletedEvent event, Emitter<OnboardingState> emit,) async
  {
    emit(OnboardingLoadingState());

    final result = await setOnboardingCompletedUseCase();

    result.fold
    (
      (failure)
      {
        emit(const OnboardingErrorState(message: "Onboarding Error"));
      },
      (_)
      {
        //debug
        print("Onboarding completed successfully");

        emit(OnboardingSuccessState());
      },
    );
  }
}