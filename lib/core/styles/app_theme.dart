import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryContainer,
      tertiary: AppColors.tertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      appBarColor: AppColors.appBarColor,
      error: AppColors.error,
      errorContainer: AppColors.errorContainer,
    ),
    useMaterial3ErrorColors: true,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useMaterial3Typography: true,
      segmentedButtonUnselectedForegroundSchemeColor:
          SchemeColor.primaryContainer,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      fabSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      drawerSelectedItemSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    useMaterial3: false,
  );
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: AppColors.primaryDark,
      primaryContainer: AppColors.primaryContainerDark,
      primaryLightRef: AppColors.primaryLightRefDark,
      secondary: AppColors.secondaryDark,
      secondaryContainer: AppColors.secondaryContainerDark,
      secondaryLightRef: AppColors.secondaryLightRefDark,
      tertiary: AppColors.tertiaryDark,
      tertiaryContainer: AppColors.tertiaryContainerDark,
      tertiaryLightRef: AppColors.tertiaryLightRefDark,
      appBarColor: AppColors.appBarColorDark,
      error: AppColors.errorDark,
      errorContainer: AppColors.errorContainerDark,
    ),
    useMaterial3ErrorColors: true,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useMaterial3Typography: true,
      segmentedButtonUnselectedForegroundSchemeColor:
          SchemeColor.primaryContainer,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      fabSchemeColor: SchemeColor.primary,
      alignedDropdown: true,
      drawerSelectedItemSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    useMaterial3: false,
  );
}
