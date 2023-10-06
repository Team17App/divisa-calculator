// ignore_for_file: file_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
// get Map item to shared
  static Future<Map<String, dynamic>> getMap(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final str = pref.getString(key) ?? '';
      final map = jsonDecode(str);
      return map;
    } on Exception catch (_) {
      return const {};
    }
  }

  // get Map item to shared
  static Future<bool> setMap(String key, Object? mapValue) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final map = jsonEncode(mapValue);
      return pref.setString(key, map);
    } on Exception catch (_) {
      return false;
    }
  }

  // delete item to shared
  static Future<void> remove(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  // clean all data to shared
  static Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  // getters

  static Future<String> getString(String key, [String strDefault = ""]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? strDefault;
  }

  static Future<int> getInt(String key, [int strDefault = -1]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key) ?? strDefault;
  }

  static Future<bool> getBool(String key, [bool strDefault = false]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? strDefault;
  }

  static Future<double?> getDouble(String key, [double? strDefault]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getDouble(key) ?? strDefault;
  }

  static Future<List<String>> getListString(List<String> keys) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> list = [];
    for (var key in keys) {
      final value = pref.getString(key) ?? "";
      if (value.isNotEmpty) {
        list.add(value);
      }
    }
    return list;
  }

  // setters

  static Future<void> setString(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  static Future<void> setInt(String key, var value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  static Future<void> setBool(String key, var value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  static Future<void> setDouble(String key, var value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  static Future<void> setListString(Map<String, String> map) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (var i = 0; i < map.length; i++) {
      await pref.setString(map.keys.elementAt(i), map.values.elementAt(i));
    }
  }

  // toggle
  static Future<bool> toggleKey(String key, [bool? strDefault]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final value = pref.getBool(key) ?? strDefault ?? false;
    await pref.setBool(key, !value);
    return !value;
  }
}
