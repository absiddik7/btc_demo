import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  static const String _tokenKey = 'user_id_token';
  static const String _planKey = 'selected_plan';

  // Setter and getter for dark mode theme
  Future setIsDarkMode(bool mode) async {
    await prefs.then((value) => value.setBool("theme_mode", mode));
  }

  // Getter for dark mode theme
  Future getIsDarkMode() async {
    return await prefs.then((value) => value.getBool("theme_mode"));
  }

  // Setter and getter for system theme usage
  Future setUseSystemTheme(bool useSystemTheme) async {
    await prefs.then((value) => value.setBool("use_system_theme", useSystemTheme));
  }

  // Getter for system theme usage
  Future getUseSystemTheme() async {
    return await prefs.then((value) => value.getBool("use_system_theme"));
  }

  // Setter and getter for app language
  Future setAppLanguage(String appLang) async {
    await prefs.then((value) => value.setString('language_code', appLang));
  }

  // Getter for app language
  Future getAppLanguage() async {
    return await prefs.then((value) => value.getString("language_code"));
  }

  // Setter and getter for user onboarding status
  Future setIsOnboarded(bool isOnBoarded) async {
    await prefs.then((value) => value.setBool('ISONBOARDED', isOnBoarded));
  }

  // Getter for user onboarding status
  Future getIsOnboarded() async {
    return await prefs.then((value) => value.getBool("ISONBOARDED"));
  }

  // Setter and getter for user onboarding status
  Future savePlan(String plan) async {
    await prefs.then((value) => value.setString(_planKey, plan));
  }
  // Getter for user onboarding status
  Future<String> getPlan() async {
    return await prefs.then((value) => value.getString(_planKey) ?? 'Annual');
  }
  // Clear the saved plan
  Future<void> clearPlan() async {
    await prefs.then((value) => value.remove(_planKey));
  }

  // Save the ID token
  Future<void> saveIDToken(String token) async {
    await prefs.then((value) => value.setString(_tokenKey, token));
  }

  // Retrieve the saved token
  Future<String?> getIDToken() async {
    return prefs.then((value) => value.getString(_tokenKey));
  }

  // Remove the token (useful for logout)
  Future<void> removeIDToken() async {
    await prefs.then((value) => value.remove(_tokenKey));
  }
}
