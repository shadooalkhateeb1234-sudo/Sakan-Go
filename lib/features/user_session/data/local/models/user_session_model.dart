import '../../../domain/entities/user_session_entity.dart';

class UserSessionModel extends UserSessionEntity
{
  const UserSessionModel({super.phoneNumber, super.cookie, super.token, super.tokenExpiresAt, required super.isOnboardingCompleted, required super.isProfileCompleted, required super.userStatus, required super.userRole});

  factory UserSessionModel.fromEntity(UserSessionEntity userSessionEntity)
  {
    return UserSessionModel
    (
      phoneNumber: userSessionEntity.phoneNumber,
      cookie: userSessionEntity.cookie,
      token: userSessionEntity.token,
      tokenExpiresAt : userSessionEntity.tokenExpiresAt,
      isOnboardingCompleted: userSessionEntity.isOnboardingCompleted,
      isProfileCompleted: userSessionEntity.isProfileCompleted,
      userStatus: userSessionEntity.userStatus,
      userRole: userSessionEntity.userRole
    );
  }

  factory UserSessionModel.fromJson(Map<String, dynamic> json)
  {
    return UserSessionModel
    (
      phoneNumber: json['phoneNumber'],
      cookie: json['cookie'],
      token: json['token'],
      tokenExpiresAt: json['tokenExpiresAt'] != null ? DateTime.parse(json['tokenExpiresAt']) : null,
      isOnboardingCompleted: json['isOnboardingCompleted'],
      isProfileCompleted: json['isProfileCompleted'],
      userStatus: UserStatus.values[json['userStatus']],
      userRole: UserRole.values[json['userRole']]
    );
  }

  Map<String, dynamic> toJson()
  {
    return
    {
      'phoneNumber': phoneNumber,
      'cookie': cookie,
      'token': token,
      'tokenExpiresAt': tokenExpiresAt?.toIso8601String(),
      'isOnboardingCompleted': isOnboardingCompleted,
      'isProfileCompleted': isProfileCompleted,
      'userStatus': userStatus.index,
      'userRole': userRole.index
    };
  }
}