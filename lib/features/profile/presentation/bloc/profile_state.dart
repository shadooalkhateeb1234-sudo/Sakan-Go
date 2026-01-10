import 'package:equatable/equatable.dart';

import '../../domain/entities/profile_entity.dart';

enum ProfileStatus { initial, loading, success, failure, validationError }

class ProfileState extends Equatable
{
  final ProfileEntity profileEntity;
  final ProfileStatus profileStatus;
  final Map<String, List<String>>? fieldErrors;

  const ProfileState({required this.profileEntity, required this.profileStatus, this.fieldErrors});

  factory ProfileState.initial()
  {
    return ProfileState(profileEntity: const ProfileEntity(), profileStatus: ProfileStatus.initial, fieldErrors: const {});
  }

  ProfileState copyWith({ProfileEntity? profileEntity, ProfileStatus? profileStatus, Map<String, List<String>>? fieldErrors})
  {
    return ProfileState
    (
      profileEntity: profileEntity ?? this.profileEntity,
      profileStatus: profileStatus ?? this.profileStatus,
      fieldErrors: fieldErrors ?? const {}
    );
  }

  @override
  List<Object?> get props => [profileEntity, profileStatus, fieldErrors];
}