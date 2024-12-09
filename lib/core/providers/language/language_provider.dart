import 'package:flutter/material.dart';
import 'package:mybtccanvas/core/services/local_storage/app_sharedpreference.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _appLocale;
  String? _currentLang;

  Locale? get appLocale => _appLocale;
  String? get currentLang => _currentLang;

  LanguageProvider() {
    loadLangFromSP();
  }

  // Load the language from shared preferences
  void loadLangFromSP() async {
    String lang = await AppSharedPreferences().getAppLanguage() ?? 'en';
    _appLocale = Locale(lang);
    _currentLang = lang;
    notifyListeners();
  }

  // Change the language and save it to shared preferences
  void changeLanguage(Locale locale) async {
    _appLocale = locale;

    if (locale == const Locale('en')) {
      _currentLang = "en"; // English
    } else if (locale == const Locale('de')) {
      _currentLang = "de"; // German
    } else if (locale == const Locale('it')) {
      _currentLang = "it"; // Italian
    } else if (locale == const Locale('es')) {
      _currentLang = "es"; // Spanish
    }

    // Save the current language to shared preferences
    await AppSharedPreferences().setAppLanguage(_currentLang!);
    notifyListeners();
  }
}
