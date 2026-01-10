
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme
{
  static ThemeData getTheme({required bool isDark})
  {
    return isDark ? dark : light;
  }

  static ThemeData light = FlexThemeData.light
    (
      colors: const FlexSchemeColor
        (
          primary: AppColors.blue600,
          primaryContainer: AppColors.blue600,
          secondary: AppColors.slate100,
          secondaryContainer: AppColors.slate100,
          tertiary: AppColors.blue600,
          tertiaryContainer: AppColors.slate100,
          appBarColor: AppColors.slate100,
          error: AppColors.red500,
          errorContainer: AppColors.red200
      ),
      subThemesData: const FlexSubThemesData
        (
          interactionEffects: true,
          tintedDisabledControls: true,
          useMaterial3Typography: true,
          segmentedButtonUnselectedForegroundSchemeColor: SchemeColor.primaryContainer,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          fabSchemeColor: SchemeColor.primary,
          alignedDropdown: true,
          drawerSelectedItemSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.primary,
          navigationRailUseIndicator: true
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      useMaterial3: false
  );

  static ThemeData dark = FlexThemeData.dark
    (
      colors: const FlexSchemeColor
        (
          primary: AppColors.blue500,
          primaryContainer: AppColors.blue500,
          primaryLightRef: AppColors.blue600,
          secondary: AppColors.slate800,
          secondaryContainer: AppColors.slate800,
          secondaryLightRef: AppColors.slate100,
          tertiary: AppColors.slate800,
          tertiaryContainer: AppColors.slate800,
          tertiaryLightRef: AppColors.slate100,
          appBarColor: AppColors.slate100,
          error: AppColors.red900,
          errorContainer: AppColors.red900
      ),
      subThemesData: const FlexSubThemesData
        (
          interactionEffects: true,
          tintedDisabledControls: true,
          blendOnColors: true,
          useMaterial3Typography: true,
          segmentedButtonUnselectedForegroundSchemeColor: SchemeColor.primaryContainer,
          inputDecoratorIsFilled: true,
          inputDecoratorBorderType: FlexInputBorderType.outline,
          fabSchemeColor: SchemeColor.primary,
          alignedDropdown: true,
          drawerSelectedItemSchemeColor: SchemeColor.primary,
          navigationRailSelectedIconSchemeColor: SchemeColor.primary,
          navigationRailUseIndicator: true
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      useMaterial3: false
  );
}
