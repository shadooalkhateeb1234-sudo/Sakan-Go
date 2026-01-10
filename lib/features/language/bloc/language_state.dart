import '../domain/entities/language_entity.dart';

enum LanguageStatus { initial, loading, success, error }

class LanguageState
{
  final LanguageStatus languageStatus;
  final String? errorMessage;
  final LanguageEntity? languageEntity;

  LanguageState._({required this.languageStatus, this.errorMessage, this.languageEntity});

  factory LanguageState.initial() => LanguageState._(languageStatus: LanguageStatus.initial);

  LanguageState copyWith({LanguageStatus? languageStatus, String? errorMessage, LanguageEntity? languageEntity})
  {
    return LanguageState._
    (
      languageStatus: languageStatus ?? this.languageStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      languageEntity: languageEntity ?? this.languageEntity
    );
  }
}