import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../domain/entities/language_entity.dart';

abstract class LanguageLocalDatasource
{
  Future<LanguageEntity?> getLanguage();

  Future<void> saveLanguage(LanguageEntity languageEntity);
}

class LanguageLocalDatasourceImpl implements LanguageLocalDatasource
{
  final SharedPreferences sharedPreferences;

  LanguageLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<LanguageEntity?> getLanguage() async
  {
    var language = sharedPreferences.getString(CacheKeys.appLanguage);
    if (language == 'ar')
    {
      return LanguageEntity(languageType: LanguageType.ar);
    }
    return LanguageEntity(languageType: LanguageType.en);
  }

  @override
  Future<void> saveLanguage(LanguageEntity languageEntity) async
  {
    var language = languageEntity.languageType == LanguageType.ar ? 'ar' : 'en';
    await sharedPreferences.setString(CacheKeys.appLanguage, language);
  }
}