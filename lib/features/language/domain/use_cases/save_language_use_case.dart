import '../repositories/language_repository.dart';
import '../entities/language_entity.dart';

class SaveLanguageUseCase
{
  final LanguageRepository languageRepository;

  SaveLanguageUseCase({required this.languageRepository});

  Future call(LanguageEntity languageEntity) async
  {
    return await languageRepository.saveLanguage(languageEntity);
  }
}