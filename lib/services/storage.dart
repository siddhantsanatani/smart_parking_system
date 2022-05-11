import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_items.dart';

class SecureStorage {
  final secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(StorageItem newItem) async {
    //debugPrint("Writing new data having key ${newItem.key}");
    await secureStorage.write(
      key: newItem.key,
      value: newItem.value,
    );
  }

  Future<String?> readSecureData(String key) async {
    //debugPrint("Reading data having key $key");
    var readData = await secureStorage.read(key: key);
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    //debugPrint("Deleting data having key ${item.key}");
    await secureStorage.delete(key: item.key);
  }

  Future<List<StorageItem>> readAllSecureData() async {
    //debugPrint("Reading all secured data");
    var allData = await secureStorage.readAll();
    List<StorageItem> list =
        allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  Future<void> deleteAllSecureData() async {
    //debugPrint("Deleting all secured data");
    await secureStorage.deleteAll();
  }

  Future<bool> containsKeyInSecureData(String key) async {
    //debugPrint("Checking data for the key $key");
    var containsKey = await secureStorage.containsKey(
      key: key,
    );
    return containsKey;
  }
}
