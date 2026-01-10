import '../../../language/domain/entities/language_entity.dart';

abstract class  LanguageRepository
{
  Future<LanguageEntity?> getLanguage();

  Future saveLanguage(LanguageEntity languageEntity);
}