import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class LocalPersistenceService {
  static const _boxName = 'zim_heritage_cache';
  late Box<String> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  Future<void> cacheData(String key, dynamic data) async {
    await _box.put(key, jsonEncode(data));
  }

  T? getCachedData<T>(String key, T Function(dynamic) fromJson) {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      return fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  String? getString(String key) => _box.get(key);

  Future<void> setString(String key, String value) async {
    await _box.put(key, value);
  }

  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  bool containsKey(String key) => _box.containsKey(key);

  Future<void> cacheUserSession(String userId, String userData) async {
    await _box.put('session_user_id', userId);
    await _box.put('session_user_data', userData);
  }

  String? getCachedUserId() => _box.get('session_user_id');
  String? getCachedUserData() => _box.get('session_user_data');

  Future<void> clearSession() async {
    await _box.delete('session_user_id');
    await _box.delete('session_user_data');
  }
}
