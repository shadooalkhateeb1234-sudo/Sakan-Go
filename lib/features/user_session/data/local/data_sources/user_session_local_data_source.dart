import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../../core/cache/cache_keys.dart';
import '../../../../../core/error/exceptions.dart';
import '../../factories/user_session_default.dart';
import '../models/user_session_model.dart';

abstract class UserSessionLocalDataSource
{
  Future<void> cacheUserSession(UserSessionModel userSessionModel);

  Future<void> clearUserSession();

  Future<UserSessionModel> getUserSession();

  Future<void> setOnboardingCompleted();
}

class UserSessionLocalDataSourceImpl implements UserSessionLocalDataSource
{
  final SharedPreferences sharedPreferences;

  UserSessionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserSession(UserSessionModel userSessionModel) async
  {
    final jsonUserSession = jsonEncode(userSessionModel.toJson());
    final cachedUserSession = await sharedPreferences.setString(CacheKeys.userSession, jsonUserSession);
    if (!cachedUserSession) throw CacheException();
  }

  @override
  Future<void> clearUserSession() async
  {
    final clearUserSession = await sharedPreferences.remove(CacheKeys.userSession);
    if (!clearUserSession) throw CacheException();
  }

  @override
  Future<UserSessionModel> getUserSession() async
  {
    final userSession = sharedPreferences.getString(CacheKeys.userSession);
    if (userSession != null)
    {
      return UserSessionModel.fromJson(json.decode(userSession));
    }
    final userSessionDefault = UserSessionDefault.create();
    await sharedPreferences.setString(CacheKeys.userSession, json.encode(userSessionDefault.toJson()));
    return userSessionDefault;
  }

  @override
  Future<void> setOnboardingCompleted() async
  {
    final userSession = await getUserSession();
    final updateUserSession = userSession.copyWith(isOnboardingCompleted: true);
    await cacheUserSession(UserSessionModel.fromEntity(updateUserSession));
  }
}