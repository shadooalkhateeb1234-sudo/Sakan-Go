import '../repositories/theme_repository.dart';
import '../entities/theme_entity.dart';

class GetThemeUseCase
{
  final ThemeRepository themeRepository;

  GetThemeUseCase({required this.themeRepository});

  Future<ThemeEntity?> call() async
  {
    return await themeRepository.getTheme();
  }
}