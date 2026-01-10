import 'package:equatable/equatable.dart';

enum UserStatus { newUser, pending, approved, rejected }
enum UserRole { tenant, owner }

class UserSessionEntity extends Equatable
{
  final String? phoneNumber;
  final String? cookie;
  final String? token;
  final DateTime? tokenExpiresAt;
  final bool isOnboardingCompleted;
  final bool isProfileCompleted;
  final UserStatus userStatus;
  final UserRole userRole;

  const UserSessionEntity({this.phoneNumber, this.cookie, this.token, this.tokenExpiresAt, required this.isOnboardingCompleted, required this.isProfileCompleted, required this.userStatus, required this.userRole});

  UserSessionEntity copyWith({String? phoneNumber, String? cookie, String? token, DateTime? tokenExpiresAt, bool? isOnboardingCompleted, bool? isProfileCompleted, UserStatus? userStatus, UserRole? userRole})
  {
    return UserSessionEntity
    (
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cookie: cookie ?? this.cookie,
      token: token ?? this.token,
      tokenExpiresAt : tokenExpiresAt ?? this.tokenExpiresAt,
      isOnboardingCompleted: isOnboardingCompleted ?? this.isOnboardingCompleted,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      userStatus: userStatus ?? this.userStatus,
      userRole: userRole ?? this.userRole
    );
  }

  @override
  String toString()
  {
    return '(phoneNumber: $phoneNumber, cookie: $cookie, token: $token, tokenExpiresAt: $tokenExpiresAt, isOnboardingCompleted: $isOnboardingCompleted, isProfileCompleted: $isProfileCompleted, userStatus: $userStatus, userRole: $userRole)';
  }

  @override
  List<Object?> get props => [ phoneNumber, cookie, token, tokenExpiresAt, isOnboardingCompleted, isProfileCompleted, userStatus, userRole ];
}