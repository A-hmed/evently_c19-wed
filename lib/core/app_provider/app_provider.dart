import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isLight => _themeMode == ThemeMode.light;

  bool get isDark => _themeMode == ThemeMode.dark;

  Locale _locale = const Locale('en');

  bool get isEnglish => _locale == Locale('en');

  bool get isArabic => _locale == Locale('ar');

  Locale get locale => _locale;

  bool isPassword = false;

  void togglePassword() {
    isPassword = !isPassword;
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void changeLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}
