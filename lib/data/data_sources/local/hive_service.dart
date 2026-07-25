/// خدمة Hive للتخزين المؤقت
library;

import 'package:hive/hive.dart';
import '../../../core/constants/app_constants.dart';

class HiveService {
  static HiveService? _instance;
  static HiveService get instance => _instance ??= HiveService._();
  
  Box? _settingsBox;
  Box? _cacheBox;
  
  bool _isInitialized = false;

  HiveService._();

  /// تهيئة الخدمة
  Future<void> init() async {
    if (_isInitialized) return;
    
    _settingsBox = await openBox(AppConstants.boxSettings);
    _cacheBox = await openBox(AppConstants.boxCache);
    _isInitialized = true;
  }

  /// فتح صندوق جديد
  Future<Box> openBox(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    }
    return await Hive.openBox(name);
  }

  // ==================== الإعدادات ====================

  /// حفظ إعداد
  Future<void> setSetting(String key, dynamic value) async {
    await _ensureInit();
    await _settingsBox?.put(key, value);
  }

  /// الحصول على إعداد
  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox?.get(key, defaultValue: defaultValue) as T?;
  }

  /// حذف إعداد
  Future<void> removeSetting(String key) async {
    await _settingsBox?.delete(key);
  }

  // ==================== التخزين المؤقت ====================

  /// حفظ بيانات مؤقتة
  Future<void> setCache(String key, dynamic value, {Duration? ttl}) async {
    await _ensureInit();
    
    final cacheData = {
      'value': value,
      'expiry': ttl != null ? DateTime.now().add(ttl).millisecondsSinceEpoch : null,
    };
    
    await _cacheBox?.put(key, cacheData);
  }

  /// الحصول على بيانات مؤقتة
  T? getCache<T>(String key) {
    final data = _cacheBox?.get(key);
    if (data == null) return null;
    
    final cacheData = data as Map;
    final expiry = cacheData['expiry'];
    
    // التحقق من انتهاء الصلاحية
    if (expiry != null && DateTime.now().millisecondsSinceEpoch > expiry) {
      _cacheBox?.delete(key);
      return null;
    }
    
    return cacheData['value'] as T?;
  }

  /// حذف بيانات مؤقتة
  Future<void> removeCache(String key) async {
    await _cacheBox?.delete(key);
  }

  /// مسح جميع البيانات المؤقتة
  Future<void> clearCache() async {
    await _cacheBox?.clear();
  }

  // ==================== أدوات مساعدة ====================

  /// التأكد من التهيئة
  Future<void> _ensureInit() async {
    if (!_isInitialized) {
      await init();
    }
  }

  /// التحقق من وجود مفتاح
  Future<bool> containsKey(String key) async {
    final settingsContains = _settingsBox?.containsKey(key) ?? false;
    final cacheContains = _cacheBox?.containsKey(key) ?? false;
    return settingsContains || cacheContains;
  }

  /// الحصول على جميع مفاتيح الإعدادات
  Iterable<dynamic>? get settingsKeys => _settingsBox?.keys;

  /// إغلاق جميع الصناديق
  Future<void> close() async {
    await _settingsBox?.close();
    await _cacheBox?.close();
    _isInitialized = false;
  }
}
