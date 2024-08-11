import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kIsDarkMode = 'DARK_MODE';
const String _kFirstLaunch = 'FIRST_LAUNCH';

class SharedPreferencesService {
  SharedPreferences? _prefs;

  Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isDarkMode =>
      _prefs?.getBool(_kIsDarkMode) ?? ThemeMode.system == ThemeMode.dark;
  set isDarkMode(bool value) => _prefs?.setBool(_kIsDarkMode, value);

  bool get isFirstLaunch => _prefs?.getBool(_kFirstLaunch) ?? true;
  set isFirstLaunch(bool value) => _prefs?.setBool(_kFirstLaunch, value);
}
