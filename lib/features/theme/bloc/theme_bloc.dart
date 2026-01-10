import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:sakan_go_mobile_app/features/theme/domain/use_cases/save_theme_use_case.dart';
import 'package:sakan_go_mobile_app/features/theme/domain/use_cases/get_theme_use_case.dart';
import 'package:sakan_go_mobile_app/features/theme/domain/entities/theme_entity.dart';
import 'package:sakan_go_mobile_app/features/theme/bloc/theme_state.dart';
import 'package:sakan_go_mobile_app/features/theme/bloc/theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>
{
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase,required this.saveThemeUseCase}) : super(ThemeState.initial())
  {
    on<GetThemeEvent>(onGetThemeEvent);
    on<ToggleThemeEvent>(onToggleThemeEvent);
  }

  Future onGetThemeEvent(GetThemeEvent event, Emitter<ThemeState> emit) async
  {
    emit(state.copyWith(themeStatus: ThemeStatus.loading));
    try
    {
      var theme = await getThemeUseCase();
      emit(state.copyWith(themeStatus: ThemeStatus.success, themeEntity: theme));
    }
    catch(e)
    {
      emit(state.copyWith(themeStatus: ThemeStatus.error, errorMessage: e.toString()));
    }
  }

  Future onToggleThemeEvent(ToggleThemeEvent event, Emitter<ThemeState> emit) async
  {
    if(state.themeEntity!= null)
    {
      var newThemeType = state.themeEntity!.themeType == ThemeType.dark ? ThemeType.light : ThemeType.dark;
      var newThemeEntity = ThemeEntity(themeType: newThemeType);
      try
      {
        await saveThemeUseCase(newThemeEntity);
        emit(state.copyWith(themeStatus: ThemeStatus.success,themeEntity: newThemeEntity));
      }
      catch(e)
      {
        emit(state.copyWith(themeStatus: ThemeStatus.error, errorMessage: e.toString()));
      }
    }
  }
}