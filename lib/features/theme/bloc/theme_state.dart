
import '../domain/entities/theme_entity.dart';

enum ThemeStatus { initial, loading, success, error }

class ThemeState
{
  final ThemeStatus themeStatus;
  final String? errorMessage;
  final ThemeEntity? themeEntity;

  ThemeState._({required this.themeStatus, this.errorMessage, this.themeEntity});

  factory ThemeState.initial() => ThemeState._(themeStatus: ThemeStatus.initial);

  ThemeState copyWith({ThemeStatus? themeStatus, String? errorMessage, ThemeEntity? themeEntity})
  {
    return ThemeState._
    (
      themeStatus: themeStatus ?? this.themeStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      themeEntity: themeEntity ?? this.themeEntity
    );
  }
}