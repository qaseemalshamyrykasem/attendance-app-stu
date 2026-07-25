/// تنفيذ مخزن الإعدادات
library;

import 'package:drift/drift.dart';
import '../../data/data_sources/local/shared_prefs_service.dart';
import '../../data/data_sources/local/local_database.dart';
import '../../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPrefsService _prefs;
  final AppDatabase _database;

  SettingsRepositoryImpl({
    required SharedPrefsService prefs,
    required AppDatabase database,
  })  : _prefs = prefs,
        _database = database;

  @override
  Future<String?> getThemeMode() async {
    return await _prefs.getThemeMode();
  }

  @override
  Future<void> setThemeMode(String mode) async {
    await _prefs.setThemeMode(mode);
    
    // حفظ في قاعدة البيانات أيضاً
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('theme_mode'),
      value: Value(mode),
      type: const Value('string'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    return await _prefs.areNotificationsEnabled();
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setNotificationsEnabled(enabled);
    
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('notifications_enabled'),
      value: Value(enabled.toString()),
      type: const Value('bool'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> toggleNotifications(bool value) async {
    await setNotificationsEnabled(value);
  }

  @override
  Future<bool> isAutoScanEnabled() async {
    final setting = await _database.getSetting('auto_scan');
    return setting?.value == 'true';
  }

  @override
  Future<void> setAutoScanEnabled(bool enabled) async {
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('auto_scan'),
      value: Value(enabled.toString()),
      type: const Value('bool'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<bool> isVibrationEnabled() async {
    final setting = await _database.getSetting('vibration_enabled');
    return setting?.value != 'false'; // افتراضي مفعل
  }

  @override
  Future<void> setVibrationEnabled(bool enabled) async {
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('vibration_enabled'),
      value: Value(enabled.toString()),
      type: const Value('bool'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<bool> isSoundEnabled() async {
    final setting = await _database.getSetting('sound_enabled');
    return setting?.value != 'false'; // افتراضي مفعل
  }

  @override
  Future<void> setSoundEnabled(bool enabled) async {
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('sound_enabled'),
      value: Value(enabled.toString()),
      type: const Value('bool'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<String?> getLastIpAddress() async {
    final setting = await _database.getSetting('last_ip_address');
    return setting?.value;
  }

  @override
  Future<void> setLastIpAddress(String ip) async {
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('last_ip_address'),
      value: Value(ip),
      type: const Value('string'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<int?> getLastPort() async {
    final setting = await _database.getSetting('last_port');
    if (setting?.value == null) return null;
    return int.tryParse(setting!.value);
  }

  @override
  Future<void> setLastPort(int port) async {
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('last_port'),
      value: Value(port.toString()),
      type: const Value('int'),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> saveConnectionInfo({required String ip, required int port}) async {
    await setLastIpAddress(ip);
    await setLastPort(port);
  }

  @override
  Future<Map<String, String>> getAllSettings() async {
    final themeMode = await getThemeMode();
    final notifications = await areNotificationsEnabled();

    return {
      'theme_mode': themeMode ?? 'system',
      'notifications_enabled': notifications.toString(),
    };
  }

  @override
  Future<void> resetSettings() async {
    await resetToDefaults();
  }

  @override
  Future<void> resetToDefaults() async {
    await _prefs.setThemeMode('system');
    await _prefs.setNotificationsEnabled(true);
    
    // إعادة تعيين إعدادات قاعدة البيانات
    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('theme_mode'),
      value: const Value('system'),
      type: const Value('string'),
      updatedAt: Value(DateTime.now()),
    ));

    await _database.saveSetting(SettingsTableCompanion(
      key: const Value('notifications_enabled'),
      value: const Value('true'),
      type: const Value('bool'),
      updatedAt: Value(DateTime.now()),
    ));
  }
}
