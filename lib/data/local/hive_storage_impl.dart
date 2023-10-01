import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/local/app_local_storage.dart';

@Singleton(as: AppLocalStorage)
class HiveStorageImpl implements AppLocalStorage {
  final Box<dynamic> _box;

  HiveStorageImpl(this._box);

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<bool?> getBool(String key) {
    return _box.get(key);
  }

  @override
  Future<double?> getDouble(String key) {
    return _box.get(key);
  }

  @override
  int? getInt(String key) {
    return _box.get(key);
  }

  @override
  Future<List<String>> getListString(String key) {
    return _box.get(key);
  }

  @override
  String? getString(String key) {
    return _box.get(key);
  }

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    await _box.put(key, value);
  }
}
