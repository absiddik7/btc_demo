import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/themes/theme/app_themes.dart';
import 'package:mybtccanvas/ui/themes/theme/custom_theme.dart';
import 'package:mybtccanvas/core/services/local_storage/app_sharedpreference.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool _useSystemTheme = false;

  bool get isDarkMode => _isDarkMode;
  bool get useSystemTheme => _useSystemTheme;

  CustomTheme _currentTheme = AppThemes.lightTheme;
  CustomTheme get currentTheme => _currentTheme;

  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  // Switch themes manually or based on the system
  void switchTheme({bool? isSystemTheme, bool? isDarkMode}) async {
    if (isSystemTheme == true) {
      _useSystemTheme = true;
      checkSystemTheme(); // Check and apply the system theme
    } else if (isDarkMode != null) {
      _useSystemTheme = false;
      _isDarkMode = isDarkMode;
      _updateCurrentTheme();
    }

    // Save both theme preferences
    await AppSharedPreferences().setUseSystemTheme(_useSystemTheme);
    await AppSharedPreferences().setIsDarkMode(_isDarkMode); // Save the current mode (dark/light)

    notifyListeners();
  }

  // Update the current theme (light or dark)
  void _updateCurrentTheme() {
    _currentTheme = _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
  }

  // Check and apply the system theme when the system theme is selected
  void checkSystemTheme() async {
    if (_useSystemTheme) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      bool isDark = brightness == Brightness.dark;

      // Update and save the current mode
      _isDarkMode = isDark;
      _updateCurrentTheme();

      // Save the current dark mode setting
      await AppSharedPreferences().setIsDarkMode(_isDarkMode);

      notifyListeners();
    }
  }

  // Load saved theme preferences from storage
  Future<void> _loadThemeFromPreferences() async {
    _useSystemTheme = await AppSharedPreferences().getUseSystemTheme() ?? false;

    if (_useSystemTheme) {
      checkSystemTheme(); // Apply system theme if selected
    } else {
      _isDarkMode = await AppSharedPreferences().getIsDarkMode() ?? false;
      _updateCurrentTheme();
    }

    notifyListeners();
  }
}
