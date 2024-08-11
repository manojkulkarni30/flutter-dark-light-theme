import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ioc_app/locator.dart';
import 'package:ioc_app/services/shared_preferences_service.dart';

class ThemeNotifier extends AutoDisposeNotifier<ThemeMode> {
  late SharedPreferencesService _pref;

  @override
  ThemeMode build() {
    _pref = locator<SharedPreferencesService>();
    final currentThemeMode =
        _pref.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    print('[ThemeNofitifer] ${_pref.isDarkMode}, $hashCode');

    ref.onDispose(() {
      print('[ThemeNotifier] disposed');
    });
    return currentThemeMode;
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      _pref.isDarkMode = true;
    } else {
      state = ThemeMode.light;
      _pref.isDarkMode = false;
    }
  }
}

final themeProvider =
    NotifierProvider.autoDispose<ThemeNotifier, ThemeMode>(ThemeNotifier.new);
