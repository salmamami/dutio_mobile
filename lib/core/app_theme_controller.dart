import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeController extends ChangeNotifier {
  AppThemeController._();

  static final AppThemeController instance = AppThemeController._();
  static const _darkModeKey = 'dutio_dark_mode';

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    _isDarkMode = preferences.getBool(_darkModeKey) ?? false;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    if (_isDarkMode == value) return;

    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setBool(_darkModeKey, value);
    if (!saved) {
      throw StateError('Could not persist the Dutio theme preference.');
    }

    _isDarkMode = value;
    notifyListeners();
  }
}
