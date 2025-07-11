import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  int _cardsPerRow = 2;

  ThemeMode get themeMode => _themeMode;
  int get cardsPerRow => _cardsPerRow;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void updateCardsPerRow(int value) {
    _cardsPerRow = value;
    notifyListeners();
  }
}
