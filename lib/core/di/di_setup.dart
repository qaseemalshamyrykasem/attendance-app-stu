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
import '../../data/models/student_model.dart';

// قاعدة البيانات
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// الخدمات
final hiveServiceProvider = Provider<HiveService>((ref) => HiveService.instance);
final sharedPrefsProvider = Provider<SharedPrefsService>((ref) => SharedPrefsService.instance);
final httpClientProvider = Provider<HttpClient>((ref) => HttpClient());
final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

// المستودعات (Repositories)
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final hive = ref.watch(hiveServiceProvider);
  final prefs = ref.watch(sharedPrefsProvider);
  return StudentRepositoryImpl(database: db, hive: hive, prefs: prefs);
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final http = ref.watch(httpClientProvider);
  return AttendanceRepositoryImpl(database: db, httpClient: http);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  final db = ref.watch(databaseProvider);
  return SettingsRepositoryImpl(prefs: prefs, database: db);
});

// ==================== البروفايدرز التفاعلية (Reactive) ====================

/// موفر بيانات الطالب الحالي - يتحدث تلقائياً
final currentStudentProvider = FutureProvider<StudentModel?>((ref) async {
  final repo = ref.watch(studentRepositoryProvider);
  return await repo.getStudent();
});

/// موفر حالة الثيم
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.read(settingsRepositoryProvider));
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SettingsRepository _settingsRepository;
  ThemeModeNotifier(this._settingsRepository) : super(ThemeMode.system);

  Future<void> loadThemeMode() async {
    final mode = await _settingsRepository.getThemeMode();
    if (mode == 'light') state = ThemeMode.light;
    else if (mode == 'dark') state = ThemeMode.dark;
    else state = ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final modeString = mode == ThemeMode.light ? 'light' : mode == ThemeMode.dark ? 'dark' : 'system';
    await _settingsRepository.setThemeMode(modeString);
    state = mode;
  }
}
