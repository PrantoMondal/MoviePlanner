import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark }

class ThemeCubit extends Cubit<AppThemeMode> {
  static const _themeKey = 'app_theme';

  ThemeCubit() : super(AppThemeMode.dark) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey);

    if (isDark != null) {
      emit(isDark ? AppThemeMode.dark : AppThemeMode.light);
    }
  }


  Future<void> toggleTheme() async {
    final newTheme =
    state == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;

    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newTheme == AppThemeMode.dark);
  }

  Future<void> setDark() async {
    emit(AppThemeMode.dark);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, true);
  }

  Future<void> setLight() async {
    emit(AppThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, false);
  }
}
