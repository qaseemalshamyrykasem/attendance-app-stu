/// واجهة مخزن الإعدادات
library;

abstract class SettingsRepository {
  /// الحصول على وضع الثيم
  Future<String?> getThemeMode();

  /// تعيين وضع الثيم
  Future<void> setThemeMode(String mode);

  /// التحقق من تفعيل الإشعارات
  Future<bool> areNotificationsEnabled();

  /// تفعيل/إلغاء الإشعارات
  Future<void> setNotificationsEnabled(bool enabled);

  /// تفعيل/إلغاء الإشعارات (اسم بديل)
  Future<void> toggleNotifications(bool value);

  /// التحقق من المسح التلقائي
  Future<bool> isAutoScanEnabled();

  /// تفعيل/إلغاء المسح التلقائي
  Future<void> setAutoScanEnabled(bool enabled);

  /// التحقق من الاهتزاز
  Future<bool> isVibrationEnabled();

  /// تفعيل/إلغاء الاهتزاز
  Future<void> setVibrationEnabled(bool enabled);

  /// التحقق من الصوت
  Future<bool> isSoundEnabled();

  /// تفعيل/إلغاء الصوت
  Future<void> setSoundEnabled(bool enabled);

  /// الحصول على آخر IP مستخدم
  Future<String?> getLastIpAddress();

  /// حفظ آخر IP مستخدم
  Future<void> setLastIpAddress(String ip);

  /// الحصول على آخر منفذ مستخدم
  Future<int?> getLastPort();

  /// حفظ آخر منفذ مستخدم
  Future<void> setLastPort(int port);

  /// حفظ معلومات الاتصال (مساعد)
  Future<void> saveConnectionInfo({required String ip, required int port});

  /// الحصول على جميع الإعدادات
  Future<Map<String, String>> getAllSettings();

  /// إعادة تعيين للإعدادات الافتراضية
  Future<void> resetToDefaults();

  /// إعادة تعيين الإعدادات (اسم بديل)
  Future<void> resetSettings();
}
