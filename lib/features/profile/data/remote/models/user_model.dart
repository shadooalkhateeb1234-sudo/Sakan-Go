import '../../../../user_session/domain/entities/user_session_entity.dart';
import '../../../domain/entities/user_entity.dart';
import 'profile_model.dart';

class UserModel extends UserEntity
{
  const UserModel({required super.userStatus, required super.userRole, required super.phoneNumber, required super.profileEntity});

  factory UserModel.fromJson(Map<String, dynamic> json)
  {
    return UserModel
    (
      userStatus: UserStatus.values.firstWhere
      (
        (e) => e.name == json['status'],
      ),
      userRole: UserRole.values.firstWhere
      (
        (e) => e.name == json['role']
      ),
      phoneNumber: json['phone'],
      profileEntity: ProfileModel.fromJson(json['profile'])
    );
  }
}