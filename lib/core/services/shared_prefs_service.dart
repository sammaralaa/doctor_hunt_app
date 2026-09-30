import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences prefs;

  SharedPrefsService._();

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  static Future<void> setIsFirstTime(bool value) async {
    await prefs.setBool('is_first_time', value);
  }

  static bool? getIsFirstTime() {
    return prefs.getBool('is_first_time');
  }

  //----------------------------------
  static Future<void> setIsLoggedIn(bool value) async {
    await prefs.setBool('is_logged_in', value);
  }

  static bool? getIsLoggedIn() {
    return prefs.getBool('is_logged_in');
  }
  //----------------------------------
  static Future<void> setUserRole(String value) async {
    await prefs.setString('user_role', value);
  }

  static String? getUserRole() {
    return prefs.getString('user_role');
  }
}
