import 'package:flutter/material.dart';
import 'package:movie_planner/src/core/constants/app_colors.dart';
import 'package:movie_planner/src/core/constants/app_text_themes.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.secondaryLight,
    primaryColor: AppColors.primaryLight,
    canvasColor: AppColors.surfaceLight,
    cardColor: AppColors.surfaceLight,
    shadowColor: AppColors.shadowLight,
    iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.textPrimaryLight,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 4,
      iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      titleTextStyle: const TextStyle(
        color: AppColors.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: AppTextThemes.lightTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryLight,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.secondary,
    primaryColor: AppColors.primary,
    canvasColor: AppColors.surfaceColor,
    cardColor: AppColors.surfaceColor,
    shadowColor: AppColors.shadowColor,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textPrimary,
      elevation: 4,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),

    textTheme: AppTextThemes.darkTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
