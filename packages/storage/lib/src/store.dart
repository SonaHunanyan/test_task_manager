abstract interface class Store {
  Future<void> init();

  dynamic valueByKey(String key, {dynamic defaultValue});

  Future<void> setString(String key, String value);

  Future<void> setStringList(String key, List<String> value);

  Future<void> setBool(String key, bool value);

  Future<void> setInt(String key, int value);

  Future<void> remove(String key);

  Set<String>? getKeys();
}
