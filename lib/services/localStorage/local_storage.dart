import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLogin({required bool value}) async {
    return await _sharedPreferences.setBool("isLogin", value);
  }

  static bool get getLogin => _sharedPreferences.getBool("isLogin") ?? false;
}
