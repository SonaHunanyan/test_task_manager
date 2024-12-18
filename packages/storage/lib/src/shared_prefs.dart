import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/store.dart';

class SharedPrefs implements Store {
  @override
  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences? _sharedPrefs;
  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();
  @override
  dynamic valueByKey(String key, {dynamic defaultValue}) {
    return _sharedPrefs?.get(key) ?? defaultValue;
  }

  @override
  Future<void> setString(String key, String value) async {
    await _sharedPrefs?.setString(key, value);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPrefs?.setStringList(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _sharedPrefs?.setBool(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _sharedPrefs?.setInt(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _sharedPrefs?.remove(key);
  }

  @override
  Set<String>? getKeys() => _sharedPrefs?.getKeys();
}
