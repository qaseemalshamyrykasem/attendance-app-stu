/// نقطة الدخول الرئيسية للتطبيق
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/di/di_setup.dart';
import 'data/data_sources/local/local_database.dart';
import 'data/data_sources/local/hive_service.dart';
import 'data/data_sources/local/shared_prefs_service.dart';
import 'services/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الخدمات المحلية
  await HiveService.instance.init();
  await SharedPrefsService.instance.init();

  final database = AppDatabase();
  final notificationService = NotificationService();
  await notificationService.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const AttendanceStudentApp(),
    ),
  );
}
