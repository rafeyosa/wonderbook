import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  StorageServices._internal();
  static final StorageServices _instance = StorageServices._internal();
  factory StorageServices() {
    return _instance;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> remove(String key) async {
    var prefs = await _prefs;
    return await prefs.remove(key);
  }

  Future<bool> setData(String key, dynamic value) async {
    var prefs = await _prefs;
    return prefs.setString(key, json.encode(value));
  }

  Future<dynamic> getData(String key) async {
    final prefs = await _prefs;
    final data = prefs.getString(key);
    if (data != null) {
      return json.decode(data);
    }
  }

  Future<bool> setStringList(String key, List<String> value) async {
    var prefs = await _prefs;
    return prefs.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    var prefs = await _prefs;
    return prefs.getStringList(key);
  }

  Future<bool> setString(String key, String value) async {
    var prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    var prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<bool> setInt(String key, int value) async {
    var prefs = await _prefs;
    return prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    var prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<bool> setDouble(String key, double value) async {
    var prefs = await _prefs;
    return prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    var prefs = await _prefs;
    return prefs.getDouble(key);
  }

  Future<bool> setBool(String key, bool value) async {
    var prefs = await _prefs;
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    var prefs = await _prefs;
    return prefs.getBool(key);
  }
}
