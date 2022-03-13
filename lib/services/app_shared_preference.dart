import 'package:chatto_app/app_config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  late var pref;
  getAppSharedPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  void saveString(String key, String value) async {
    await pref.setString(key, value);
  }

  String getString(String key, {String? defaultValue = Constant.none}) {
    return pref.getString(key) ?? defaultValue;
  }

  void saveBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue = Constant.unchartedBool}) {
    return pref.getBool(key) ?? defaultValue;
  }

  void saveDouble(String key, double value) async {
    await pref.setDouble(key, value);
  }

  double getDouble(String key,
      {double? defaultValue = Constant.unchartedDouble}) {
    return pref.getDouble(key) ?? defaultValue;
  }

  void saveInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  int getInt(String key, {int? defaultValue = Constant.unchartedInt}) {
    return pref.getInt(key) ?? defaultValue;
  }

  void saveListString(String key, List<String> value) async {
    await pref.setStringList(key, value);
  }

  List<String> getListString(String key,
      {List<String> defaultValue = Constant.unchartedListString}) {
    return pref.getStringList(key) ?? defaultValue;
  }

  void deleteData(String key) async {
    await pref.remove(key);
  }
}
