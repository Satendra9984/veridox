import 'package:flutter/material.dart';
import 'package:veridox/core/themes/app_pallette.dart';

class AppColorTheme {
  static ThemeData darkThemeData = ThemeData.dark().copyWith(
    primaryColor: AppPalletteAbs.primaryColor,
    secondaryHeaderColor: AppPalletteAbs.secondaryColor,
  );

  static ThemeData lightThemeData = ThemeData.light();
}
