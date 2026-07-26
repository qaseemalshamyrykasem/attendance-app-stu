/// الثوابت الأساسية للتطبيق
library;

class AppConstants {
  AppConstants._();

  // معلومات التطبيق
  static const String appName = 'حضوري';
  static const String appSubtitle = 'نظام الحضور الذكي';
  static const String appVersion = '1.0.0';

  // إعدادات الشبكة الافتراضية
  static const int defaultPort = 8080;
  static const int connectionTimeout = 15000; // 15 ثانية
  static const int receiveTimeout = 20000; // 20 ثانية

  // مفاتيح التخزين المحلي
  static const String keyIsSetupComplete = 'is_setup_complete';
  static const String keyStudentId = 'student_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyLastSyncTime = 'last_sync_time';

  // QR Code
  static const int qrScanTimeout = 30; // ثانية

  // قاعدة البيانات
  static const String databaseName = 'attendance_student.db';
  static const int databaseVersion = 1;

  // Hive Boxes
  static const String boxSettings = 'settings_box';
  static const String boxCache = 'cache_box';

  // التشفير
  static const String encryptionKeyPrefix = 'attendance_';

  // أنواع الحضور
  static const String statusPresent = 'present';
  static const String statusAbsent = 'absent';
  static const String statusLate = 'late';
  static const String statusExcused = 'excused';

  // حالات الاتصال
  static const String connectionSuccess = 'success';
  static const String connectionFailed = 'failed';
  static const String connectionStatusTimeout = 'timeout';
  static const String connectionDuplicate = 'duplicate';
  static const String sessionClosed = 'session_closed';

  // المستويات الدراسية
  static const List<String> levels = [
    'المستوى الأول',
    'المستوى الثاني',
    'المستوى الثالث',
    'المستوى الرابع',
    'المستوى الخامس',
    'المستوى السادس',
    'المستوى السابع',
    'المستوى الثامن',
  ];

  // الأقسام
  static const List<String> departments = [
    'علوم الحاسب',
    'هندسة البرمجيات',
    'نظم المعلومات',
    'الأمن السيبراني',
    'الذكاء الاصطناعي',
    'شبكات الحاسب',
  ];
}

/// رسائل التطبيق
class AppMessages {
  AppMessages._();

  // رسائل النجاح
  static const String attendanceSuccess = 'تم تسجيل حضورك بنجاح';
  static const String profileSaved = 'تم حفظ بياناتك بنجاح';
  static const String profileUpdated = 'تم تحديث بياناتك بنجاح';
  static const String dataCleared = 'تم مسح جميع البيانات';

  // رسائل الأخطاء
  static const String alreadyRegistered = 'أنت مسجل مسبقاً في هذه الجلسة';
  static const String sessionClosed = 'انتهت وقت التسجيل في هذه الجلسة';
  static const String noConnection = 'تأكد من اتصالك بشبكة المندوب';
  static const String invalidData = 'بيانات غير صحيحة';
  static const String cameraPermissionDenied = 'تم رفض إذن الكاميرا';
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String serverError = 'خطأ من الخادم';

  // رسائل التحقق
  static const String nameRequired = 'يرجى إدخال الاسم';
  static const String studentIdRequired = 'يرجى إدخال الرقم الجامعي';
  static const String departmentRequired = 'يرجى اختيار القسم';
  static const String levelRequired = 'يرجى اختيار المستوى';
  static const String sectionRequired = 'يرجى إدخال الشعبة';
  static const String ipRequired = 'يرجى إدخال عنوان IP';
  static const String portRequired = 'يرجى إدخال رقم المنفذ';
  static const String invalidIpFormat = 'تنسيق IP غير صحيح';
  static const String invalidPortFormat = 'رقم المنفذ غير صحيح';

  // عناوين الشاشات
  static const String homeTitle = 'الرئيسية';
  static const String profileTitle = 'ملفي الشخصي';
  static const String historyTitle = 'سجل الحضور';
  static const String settingsTitle = 'الإعدادات';
  static const String aboutTitle = 'حول التطبيق';
  static const String scanTitle = 'مسح QR Code';
  static const String connectTitle = 'اتصال يدوي';
  static const String setupTitle = 'إعداد الملف الشخصي';
}

/// أنواع الأخطاء المخصصة
class AppErrors {
  AppErrors._();
  
  static const String networkException = 'NetworkException';
  static const String serverException = 'ServerException';
  static const String cacheException = 'CacheException';
  static const String validationException = 'ValidationException';
  static const String permissionException = 'PermissionException';
  static const String databaseException = 'DatabaseException';
}
