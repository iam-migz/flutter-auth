import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miggy/models/storage_item.dart';

class StorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AndroidOptions _androidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> saveData(StorageItem item) async {
    await _storage.write(
        key: item.key, value: item.value, aOptions: _androidOptions());
  }

  Future<String?> readData(String key) async {
    var data = await _storage.read(key: key, aOptions: _androidOptions());
    return data;
  }

  Future<List<StorageItem>> readAllData() async {
    var data = await _storage.readAll(aOptions: _androidOptions());
    List<StorageItem> items =
        data.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return items;
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: key, aOptions: _androidOptions());
  }

  Future<void> deleteAllData() async {
    await _storage.deleteAll(aOptions: _androidOptions());
  }
}