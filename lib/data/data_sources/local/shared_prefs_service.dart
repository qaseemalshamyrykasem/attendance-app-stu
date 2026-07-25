/// خدمة SharedPreferences للتخزين المحلي
library;

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class SharedPrefsService {
  static SharedPrefsService? _instance;
  static SharedPrefsService get instance => _instance ??= SharedPrefsService._();
  
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  SharedPrefsService._();

  /// تهيئة الخدمة
  Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  /// التأكد من التهيئة
  Future<SharedPreferences> get prefs async {
    if (!_isInitialized) {
      await init();
    }
    return _prefs!;
  }

  // ==================== القيم البسيطة ====================

  /// حفظ قيمة نصية
  Future<bool> setString(String key, String value) async {
    final p = await prefs;
    return await p.setString(key, value);
  }

  /// الحصول على قيمة نصية
  Future<String?> getString(String key, {String? defaultValue}) async {
    final p = await prefs;
    return p.getString(key) ?? defaultValue;
  }

  /// حفظ قيمة عددية
  Future<bool> setInt(String key, int value) async {
    final p = await prefs;
    return await p.setInt(key, value);
  }

  /// الحصول على قيمة عددية
  Future<int?> getInt(String key, {int? defaultValue}) async {
    final p = await prefs;
    return p.getInt(key) ?? defaultValue;
  }

  /// حفظ قيمة منطقية
  Future<bool> setBool(String key, bool value) async {
    final p = await prefs;
    return await p.setBool(key, value);
  }

  /// الحصول على قيمة منطقية
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final p = await prefs;
    return p.getBool(key) ?? defaultValue;
  }

  /// حفظ قائمة نصية
  Future<bool> setStringList(String key, List<String> value) async {
    final p = await prefs;
    return await p.setStringList(key, value);
  }

  /// الحصول على قائمة نصية
  Future<List<String>?> getStringList(String key) async {
    final p = await prefs;
    return p.getStringList(key);
  }

  // ==================== إعدادات التطبيق ====================

  /// التحقق من إكمال الإعداد الأولي
  Future<bool> isSetupComplete() async {
    return await getBool(AppConstants.keyIsSetupComplete);
  }

  /// تعيين إكمال الإعداد
  Future<void> setSetupComplete(bool value) async {
    await setBool(AppConstants.keyIsSetupComplete, value);
  }

  /// الحصول على معرف الطالب المحفوظ
  Future<String?> getStudentId() async {
    return await getString(AppConstants.keyStudentId);
  }

  /// حفظ معرف الطالب
  Future<void> setStudentId(String studentId) async {
    await setString(AppConstants.keyStudentId, studentId);
  }

  /// الحصول على وضع الثيم
  Future<String?> getThemeMode() async {
    return await getString(AppConstants.keyThemeMode, defaultValue: 'system');
  }

  /// حفظ وضع الثيم
  Future<void> setThemeMode(String mode) async {
    await setString(AppConstants.keyThemeMode, mode);
  }

  /// التحقق من تفعيل الإشعارات
  Future<bool> areNotificationsEnabled() async {
    return await getBool(AppConstants.keyNotificationsEnabled, defaultValue: true);
  }

  /// تفعيل/إلغاء الإشعارات
  Future<void> setNotificationsEnabled(bool enabled) async {
    await setBool(AppConstants.keyNotificationsEnabled, enabled);
  }

  /// الحصول على وقت آخر مزامنة
  Future<DateTime?> getLastSyncTime() async {
    final timestamp = await getInt(AppConstants.keyLastSyncTime);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// تحديث وقت المزامنة
  Future<void> updateSyncTime() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await setInt(AppConstants.keyLastSyncTime, now);
  }

  // ==================== إدارة البيانات ====================

  /// حذف مفتاح محدد
  Future<bool> remove(String key) async {
    final p = await prefs;
    return await p.remove(key);
  }

  /// التحقق من وجود مفتاح
  Future<bool> containsKey(String key) async {
    final p = await prefs;
    return p.containsKey(key);
  }

  /// مسح جميع البيانات
  Future<bool> clearAll() async {
    final p = await prefs;
    return await p.clear();
  }

  /// الحصول على جميع المفاتيح
  Future<Set<String>> getAllKeys() async {
    final p = await prefs;
    return p.getKeys();
  }
}
