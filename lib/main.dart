/// نقطة الدخول الرئيسية للتطبيق
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/di/di_setup.dart';
import 'data/data_sources/local/local_database.dart';
import 'data/data_sources/local/hive_service.dart';
import 'data/data_sources/local/shared_prefs_service.dart';
import 'services/notification/notification_service.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. تهيئة Hive للـ Flutter (مهم جداً قبل فتح الصناديق)
    await Hive.initFlutter();

    // 2. تهيئة الخدمات المحلية بالتوازي لسرعة التشغيل
    await Future.wait([
      HiveService.instance.init(),
      SharedPrefsService.instance.init(),
    ]);

    // 3. تهيئة قاعدة البيانات والإشعارات
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
  } catch (e, stackTrace) {
    debugPrint('Fatal error during initialization: $e');
    debugPrint(stackTrace.toString());
    
    // تشغيل واجهة بسيطة في حالة الفشل الكارثي
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'حدث خطأ أثناء تشغيل التطبيق:\n$e',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
