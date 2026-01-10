import '../repositories/theme_repository.dart';
import '../entities/theme_entity.dart';

class SaveThemeUseCase
{
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future call(ThemeEntity themeEntity) async
  {
    return await themeRepository.saveTheme(themeEntity);
  }
}