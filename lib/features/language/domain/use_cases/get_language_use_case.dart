import '../entities/language_entity.dart';
import '../repositories/language_repository.dart';

class GetLanguageUseCase
{
  final LanguageRepository languageRepository;

  GetLanguageUseCase({required this.languageRepository});

  Future<LanguageEntity?> call() async
  {
    return await languageRepository.getLanguage();
  }
}