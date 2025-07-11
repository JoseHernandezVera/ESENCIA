import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favoriteNames = [];

  List<String> get favorites => _favoriteNames;

  bool isFavorite(String name) => _favoriteNames.contains(name);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteNames.clear();
    _favoriteNames.addAll(prefs.getStringList('favorites') ?? []);
    notifyListeners();
  }

  Future<void> toggleFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteNames.contains(name)) {
      _favoriteNames.remove(name);
    } else {
      _favoriteNames.add(name);
    }
    await prefs.setStringList('favorites', _favoriteNames);
    notifyListeners();
  }
}
