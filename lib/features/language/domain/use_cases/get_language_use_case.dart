import 'package:sakan_go_mobile_app/features/language/domain/repositories/language_repository.dart';
import '../entities/language_entity.dart';

class GetLanguageUseCase
{
  final LanguageRepository languageRepository;

  GetLanguageUseCase({required this.languageRepository});

  Future<LanguageEntity?> call() async
  {
    return await languageRepository.getLanguage();
  }
}