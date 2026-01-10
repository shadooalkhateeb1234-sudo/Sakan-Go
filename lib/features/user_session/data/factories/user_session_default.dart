import '../../domain/entities/user_session_entity.dart';
import '../local/models/user_session_model.dart';

class UserSessionDefault
{
  static UserSessionModel create()
  {
    return UserSessionModel
    (
      phoneNumber: null,
      cookie: null,
      token: null,
      tokenExpiresAt: null,
      isOnboardingCompleted: false,
      isProfileCompleted: false,
      userStatus: UserStatus.newUser,
      userRole: UserRole.tenant
    );
  }
}