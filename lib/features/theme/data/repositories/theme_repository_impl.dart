import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../local/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository
{
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<ThemeEntity?> getTheme() async
  {
    return await themeLocalDatasource.getTheme();
  }

  @override
  Future<dynamic> saveTheme(ThemeEntity themeEntity) async
  {
    await themeLocalDatasource.saveTheme(themeEntity);
  }
}