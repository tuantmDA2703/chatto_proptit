import 'package:chatto_app/config/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

///   Created by Phuong Hoa
///   Sat,Mar 13th,2022
///   Call getAppSharedPreference for initial and get each function with each type of value
///   Declare key in app_config or app_constant
///   Call delete function to delete field

class AppSharedPreference {
  late var pref;
  getAppSharedPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  void saveString(String key, String value) async {
    await pref.setString(key, value);
  }

  String getString(String key, {String? defaultValue = AppConstant.none}) {
    return pref.getString(key) ?? defaultValue;
  }

  void saveBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue = AppConstant.unchartedBool}) {
    return pref.getBool(key) ?? defaultValue;
  }

  void saveDouble(String key, double value) async {
    await pref.setDouble(key, value);
  }

  double getDouble(String key,
      {double? defaultValue = AppConstant.unchartedDouble}) {
    return pref.getDouble(key) ?? defaultValue;
  }

  void saveInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  int getInt(String key, {int? defaultValue = AppConstant.unchartedInt}) {
    return pref.getInt(key) ?? defaultValue;
  }

  void saveListString(String key, List<String> value) async {
    await pref.setStringList(key, value);
  }

  List<String> getListString(String key,
      {List<String> defaultValue = AppConstant.unchartedListString}) {
    return pref.getStringList(key) ?? defaultValue;
  }

  void deleteData(String key) async {
    await pref.remove(key);
  }
}
