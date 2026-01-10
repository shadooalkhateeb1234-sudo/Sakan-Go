import 'package:bloc/bloc.dart';
import 'dart:async';
import '../domain/entities/language_entity.dart';
import '../domain/use_cases/get_language_use_case.dart';
import '../domain/use_cases/save_language_use_case.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState>
{
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;

  LanguageBloc({required this.getLanguageUseCase,required this.saveLanguageUseCase}) : super(LanguageState.initial())
  {
    on<GetLanguageEvent>(onGetLanguageEvent);
    on<ToggleLanguageEvent>(onToggleLanguageEvent);
  }

  Future onGetLanguageEvent(GetLanguageEvent event, Emitter<LanguageState> emit) async
  {
    emit(state.copyWith(languageStatus: LanguageStatus.loading));
    try
    {
      var language = await getLanguageUseCase();
      emit(state.copyWith(languageStatus: LanguageStatus.success, languageEntity: language));
    }
    catch(e)
    {
      emit(state.copyWith(languageStatus: LanguageStatus.error, errorMessage: e.toString()));
    }
  }

  Future onToggleLanguageEvent(ToggleLanguageEvent event, Emitter<LanguageState> emit) async
  {
    if(state.languageEntity!= null)
    {
      var newLanguageType = state.languageEntity!.languageType == LanguageType.ar ? LanguageType.en : LanguageType.ar;
      var newLanguageEntity = LanguageEntity(languageType: newLanguageType);
      try
      {
        await saveLanguageUseCase(newLanguageEntity);
        emit(state.copyWith(languageStatus: LanguageStatus.success,languageEntity: newLanguageEntity));
      }
      catch(e)
      {
        emit(state.copyWith(languageStatus: LanguageStatus.error, errorMessage: e.toString()));
      }
    }
  }
}