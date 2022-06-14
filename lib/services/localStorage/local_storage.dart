import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static  initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


  static Future<bool> saveUserId({required String id}) async {
    return await _sharedPreferences.setString("userId", id);
  }

  static String? get getUserId => _sharedPreferences.getString("userId");

  static Future<bool> removeUserId()async{
    return await  _sharedPreferences.remove("userId");
  }


}
