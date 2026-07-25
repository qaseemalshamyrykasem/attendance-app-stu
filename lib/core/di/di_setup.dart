/// إعداد حقن التبعيات (Dependency Injection)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/local/local_database.dart';
import '../../data/data_sources/local/hive_service.dart';
import '../../data/data_sources/local/shared_prefs_service.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/student_repository.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../services/network/http_client.dart';
import '../../services/notification/notification_service.dart';

// ==================== قاعدة البيانات ====================

/// Provider لقاعدة البيانات
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// ==================== الخدمات المحلية ====================

/// Provider لخدمة Hive
final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService.instance;
});

/// Provider لخدمة SharedPreferences
final sharedPrefsProvider = Provider<SharedPrefsService>((ref) {
  return SharedPrefsService.instance;
});

// ==================== HTTP Client ====================

/// Provider للعميل HTTP
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

// ==================== الإشعارات ====================

/// Provider لخدمة الإشعارات
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// ==================== Repositories ====================

/// Provider لمخزن بيانات الطالب
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final hive = ref.watch(hiveServiceProvider);
  final prefs = ref.watch(sharedPrefsProvider);
  return StudentRepositoryImpl(database: db, hive: hive, prefs: prefs);
});

/// Provider لمخزن بيانات الحضور
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final http = ref.watch(httpClientProvider);
  return AttendanceRepositoryImpl(database: db, httpClient: http);
});

/// Provider لمخزن الإعدادات
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  final db = ref.watch(databaseProvider);
  return SettingsRepositoryImpl(prefs: prefs, database: db);
});

// ==================== الثيم ====================

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SettingsRepository _settingsRepository;
  ThemeModeNotifier(this._settingsRepository) : super(ThemeMode.system);

  Future<void> loadThemeMode() async {
    final mode = await _settingsRepository.getThemeMode();
    if (mode != null) {
      switch (mode) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        default:
          state = ThemeMode.system;
      }
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final modeString = mode == ThemeMode.light
        ? 'light'
        : mode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await _settingsRepository.setThemeMode(modeString);
    state = mode;
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.read(settingsRepositoryProvider));
});
