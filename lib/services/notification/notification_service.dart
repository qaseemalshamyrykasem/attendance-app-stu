/// خدمة الإشعارات المحلية
library;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final Logger _logger = Logger();
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  
  bool _isInitialized = false;

  /// تهيئة خدمة الإشعارات
  Future<void> init() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _isInitialized = true;
    _logger.i('Notification service initialized');
  }

  /// معالجة النقر على إشعار
  void _onNotificationTapped(NotificationResponse response) {
    _logger.d('Notification tapped: ${response.payload}');
    // يمكن التنقل لشاشة محددة هنا
  }

  /// عرض إشعار بسيط
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) await init();

    const androidDetails = AndroidNotificationDetails(
      'attendance_channel',
      'إشعارات الحضور',
      channelDescription: 'إشعارات متعلقة بنظام الحضور',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
    _logger.i('Showing notification: $title');
  }

  /// إشعار نجاح الحضور
  Future<void> showAttendanceSuccess(String message) async {
    await showNotification(
      id: 1,
      title: '✅ تم تسجيل الحضور',
      body: message,
      payload: 'attendance_success',
    );
  }

  /// إشعار فشل الحضور
  Future<void> showAttendanceError(String message) async {
    await showNotification(
      id: 2,
      title: '❌ فشل تسجيل الحضور',
      body: message,
      payload: 'attendance_error',
    );
  }

  /// إشعار تحذير
  Future<void> showWarning(String message) async {
    await showNotification(
      id: 3,
      title: '⚠️ تحذير',
      body: message,
      payload: 'warning',
    );
  }

  /// إلغاء جميع الإشعارات
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
    _logger.d('All notifications cancelled');
  }

  /// إلغاء إشعار محدد
  Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  /// التحقق من أذونات الإشعارات (Android 13+)
  Future<bool> requestPermission() async {
    // في Android 13+ نحتاج طلب إذن صريح
    // هذا يتم عبر permission_handler
    return true;
  }
}
