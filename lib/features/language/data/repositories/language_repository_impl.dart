import '../../domain/entities/language_entity.dart';
import '../../domain/repositories/language_repository.dart';
import '../local/language_local_data_source.dart';

class LanguageRepositoryImpl implements LanguageRepository
{
  final LanguageLocalDatasource languageLocalDatasource;

  LanguageRepositoryImpl({required this.languageLocalDatasource});

  @override
  Future<LanguageEntity?> getLanguage() async
  {
    return await languageLocalDatasource.getLanguage();
  }

  @override
  Future<dynamic> saveLanguage(LanguageEntity languageEntity) async
  {
    await languageLocalDatasource.saveLanguage(languageEntity);
  }
}