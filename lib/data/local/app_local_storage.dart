abstract class AppLocalStorage {
  Future<void> saveString(String key, String value);
  Future<void> saveInt(String key, int value);
  Future<void> saveBool(String key, bool value);
  Future<void> saveDouble(String key, double value);
  Future<void> saveStringList(String key, List<String> value);
  String? getString(String key);
  int? getInt(String key);
  Future<double?> getDouble(String key);
  Future<bool?> getBool(String key);
  Future<List<String>> getListString(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
