import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EStorage {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static Future<bool> getBool(String key, [bool defaultValue = false]) async {
    final prefs = await _instance;
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    final prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<int> getInt(String key, [int defaultValue = 0]) async {
    final prefs = await _instance;
    return prefs.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    final prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<double> getDouble(String key,
      [double defaultValue = 0.0]) async {
    final prefs = await _instance;
    return prefs.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    final prefs = await _instance;
    return prefs.setDouble(key, value);
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final prefs = await _instance;
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) async {
    final prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<List<String>> getStringList(String key,
      [List<String> defaultValue = const []]) async {
    final prefs = await _instance;
    return prefs.getStringList(key) ?? defaultValue;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await _instance;
    return prefs.setStringList(key, value);
  }

  //await Storage.setObject('user', user);
  static Future<bool> setObject<T>(String key, T value) async {
    final prefs = await _instance;
    final json = jsonEncode(value);
    return prefs.setString(key, json);
  }

  //_user = Storage.getObject('user', User(name: 'Unknown', age: 0), (json) => User.fromJson(json));
  static Future<T> getObject<T>(
      String key, T defaultValue, T Function(dynamic) fromJson) async {
    final prefs = await _instance;
    final json = prefs.getString(key);
    if (json != null) {
      try {
        return fromJson(jsonDecode(json));
      } catch (e) {
        print('Error decoding object: $e');
      }
    }
    return defaultValue;
  }

  static Future<bool> remove(String key) async {
    final prefs = await _instance;
    return prefs.remove(key);
  }
}
