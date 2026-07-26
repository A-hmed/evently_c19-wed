import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.lightPrimaryColor,
    primaryColorLight: AppColors.lightPrimaryColor,
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.lightPrimaryColor,
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    primaryColor: AppColors.darkPrimaryColor,
    primaryColorLight: AppColors.darkTextColor,
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextColor,
      ),
    ),
  );
}
