import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../domain/entities/theme_entity.dart';

abstract class ThemeLocalDatasource
{
  Future<ThemeEntity?> getTheme();

  Future<void> saveTheme(ThemeEntity themeEntity);
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource
{
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeEntity?> getTheme() async
  {
    var theme = sharedPreferences.getString(CacheKeys.appTheme);
    if (theme == 'dark')
    {
      return ThemeEntity(themeType: ThemeType.dark);
    }
    return ThemeEntity(themeType: ThemeType.light);
  }

  @override
  Future<void> saveTheme(ThemeEntity themeEntity) async
  {
    var theme = themeEntity.themeType == ThemeType.dark ? 'dark' : 'light';
    await sharedPreferences.setString(CacheKeys.appTheme, theme);
  }
}