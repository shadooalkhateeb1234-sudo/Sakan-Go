import 'package:equatable/equatable.dart';
import 'package:sakan_go/features/profile/domain/entities/profile_entity.dart';
import '../../../user_session/domain/entities/user_session_entity.dart';

class UserEntity extends Equatable
{
  final UserStatus userStatus;
  final UserRole userRole;
  final String phoneNumber;
  final ProfileEntity? profileEntity;

  const UserEntity({required this.userStatus, required this.userRole, required this.phoneNumber, required this.profileEntity});

  @override
  List<Object?> get props => [ userStatus, userRole, phoneNumber, profileEntity ];
}