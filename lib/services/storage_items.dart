import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:smart_parking_system/services/storage.dart';

class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}

final api = StorageItem('API', 'AIzaSyCtpQKZE1tWznJ8ciDfT86qrO2-KA4vCvE');

final SecureStorage secureStorage = SecureStorage();
