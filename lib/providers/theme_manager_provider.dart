import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class ThemeManager with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeMode get themeMode {
    _isDarkMode = pref.getBool('isToggleOn') ?? false;

    //log('$isToggleOn');
    return _isDarkMode ? ThemeMode.light : ThemeMode.dark;
  }
}
