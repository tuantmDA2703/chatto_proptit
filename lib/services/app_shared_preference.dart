import 'package:chatto_app/app_config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  late var prefs;
  getAppSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String getString(String key, {String defaultValue = Constant.none}) {
    return prefs.getString(key) ?? defaultValue;
  }

  void saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool? getBool(String key, {bool defaultValue = Constant.unchartedBool}) {
    return prefs.getBool(key) ?? defaultValue;
  }

  void saveDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  double getDouble(String key,
      {double defaultValue = Constant.unchartedDouble}) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  void saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = Constant.unchartedInt}) {
    return prefs.getInt(key) ?? defaultValue;
  }

  void saveListString(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  List<String> getListString(String key,
      {List<String> defaultValue = Constant.unchartedListString}) {
    return prefs.getStringList(key) ?? defaultValue;
  }

  void deleteData(String key) async {
    await prefs.remove(key);
  }
}
