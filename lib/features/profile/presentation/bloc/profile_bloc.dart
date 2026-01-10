import 'package:bloc/bloc.dart';

import 'package:sakan_go_mobile_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:sakan_go_mobile_app/features/profile/presentation/bloc/profile_state.dart';
import '../../domain/use_cases/submit_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../../domain/use_cases/show_profile_use_case.dart';
import '../../../../core/errors/failures.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
{
  final ShowProfileUseCase showProfileUseCase;
  final SubmitProfileUseCase submitProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({required this.showProfileUseCase, required this.submitProfileUseCase, required this.updateProfileUseCase}) : super(ProfileState.initial())
  {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<PersonalImageChanged>(_onPersonalImageChanged);
    on<IdImageChanged>(_onIdImageChanged);

    on<ShowProfilePressed>(_onShowProfile);
    on<SubmitProfilePressed>(_onSubmitProfile);
    on<UpdateProfilePressed>(_onUpdateProfile);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<ProfileState> emit)
  {
    emit(state.copyWith(profileEntity: state.profileEntity.copyWith(firstName: event.value), fieldErrors: const {}));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<ProfileState> emit)
  {
    emit(state.copyWith(profileEntity: state.profileEntity.copyWith(lastName: event.value), fieldErrors: const {}));
  }

  void _onBirthDateChanged(BirthDateChanged event, Emitter<ProfileState> emit)
  {
    emit(state.copyWith(profileEntity: state.profileEntity.copyWith(birthDate: event.value), fieldErrors: const {}));
  }

  void _onPersonalImageChanged(PersonalImageChanged event, Emitter<ProfileState> emit)
  {
    emit(state.copyWith(profileEntity: state.profileEntity.copyWith(personalImage: event.path), fieldErrors: const {}));
  }

  void _onIdImageChanged(IdImageChanged event, Emitter<ProfileState> emit)
  {
    emit(state.copyWith(profileEntity: state.profileEntity.copyWith(idImage: event.path), fieldErrors: const {}));
  }

  Future<void> _onShowProfile(ShowProfilePressed event, Emitter<ProfileState> emit) async
  {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    final result = await showProfileUseCase();

    result.fold
    (
      (failure)
      {
        emit(state.copyWith(profileStatus: ProfileStatus.failure));
      },
      (user)
      {
        emit(state.copyWith(profileEntity: user.profileEntity ?? state.profileEntity, profileStatus: ProfileStatus.success));
      }
    );
  }

  Future<void> _onSubmitProfile(SubmitProfilePressed event, Emitter<ProfileState> emit) async
  {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    final result = await submitProfileUseCase(profileEntity: state.profileEntity);

    result.fold
    (
      (failure)
      {
        if (failure is UnprocessableEntityFailure)
        {
          emit(state.copyWith(profileStatus: ProfileStatus.validationError));
        }
        else
        {
          emit(state.copyWith(profileStatus: ProfileStatus.failure));
        }
      },
      (_)
      {
        emit(state.copyWith(profileStatus: ProfileStatus.success));
      }
    );
  }

  Future<void> _onUpdateProfile(UpdateProfilePressed event, Emitter<ProfileState> emit) async
  {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    final result = await updateProfileUseCase(profileEntity: state.profileEntity);

    result.fold
    (
      (failure)
      {
        if (failure is UnprocessableEntityFailure)
        {
          emit(state.copyWith(profileStatus: ProfileStatus.validationError));
        }
        else
        {
          emit(state.copyWith(profileStatus: ProfileStatus.failure));
        }
      },
      (user)
      {
        emit(state.copyWith( profileEntity: user.profileEntity ?? state.profileEntity, profileStatus: ProfileStatus.success));
      }
    );
  }
}