# 🗄️ توثيق قاعدة البيانات المحلية

<p align="center">
  <img src="https://img.shields.io/badge/Database-SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white" alt="SQLite" />
  <img src="https://img.shields.io/badge/ORM-Drift-2.15.0-42A5F5?style=flat-square" alt="Drift" />
  <img src="https://img.shields.io/badge/Version-1-6C757D?style=flat-square" alt="Schema Version" />
</p>

---

## 📋 جدول المحتويات

- [📖 نظرة عامة](#-نظرة-عامة)
- [🏗️ هيكل قاعدة البيانات](#-هيكل-قاعدة-البيانات)
- [👤 جدول student_profile](#--جدول-student_profile)
- [📋 جدول attendance_history](#--جدول-attendance_history)
- [⚙️ جدول settings](#--جدول-settings)
- [🔌 جدول connection_logs](#--جدول-connection_logs)
- [📊 العلاقات بين الجداول](#-العلاقات-بين-الجداول)
- [🔧 العمليات المتاحة](#-العمليات-المتاحة)
- [📁 موقع ملف قاعدة البيانات](#-موقع-ملف-قاعدة-البيانات)
- [🔄 الترحيل (Migrations)](#-الترحيل-migrations)

---

## 📖 نظرة عامة

يستخدم التطبيق **Drift (Moor)** كـ ORM للتعامل مع **SQLite** محلياً. تخزن قاعدة البيانات جميع بيانات الطالب وسجلات الحضور والإعدادات بشكل آمن على الجهاز.

### المميزات

- ✅ **تخزين محلي بالكامل** - لا يحتاج إنترنت
- ✅ **Type-safe** - فحص الأنواع في وقت الترجمة
- ✅ **React queries** - دعم Stream للاستجابة للتغييرات
- ✅ **Transactions** - عمليات ذرية آمنة
- ✅ **Migration** - ترقية مخطط قاعدة البيانات

---

## 🏗️ هيكل قاعدة البيانات

```
┌─────────────────────────────────────────────────────────────┐
│                    attendance_student.db                     │
│                    (Schema Version: 1)                       │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────┐  ┌──────────────────────────────┐     │
│  │  student_profile  │  │      attendance_history      │     │
│  │  (سجل واحد)       │  │  (عدة سجلات)                 │     │
│  └────────┬─────────┘  └──────────────┬───────────────┘     │
│           │                            │                      │
│           │         ┌──────────────────┼───────────────┐     │
│           │         │                  │               │     │
│           ▼         ▼                  ▼               ▼     │
│  ┌──────────────────┐  ┌──────────────────────────────┐     │
│  │      settings    │  │      connection_logs         │     │
│  │  (أزواج key-value)│  │  (سجل الاتصالات)            │     │
│  └──────────────────┘  └──────────────────────────────┘     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## 👤 جدول `student_profile`

يخزن بيانات الطالب الشخصية. يحتوي على **سجل واحد فقط**.

### مخطط الجدول

| العمود | النوع | القيود | الافتراضي | الوصف |
|--------|------|--------|-----------|-------|
| `id` | TEXT | PRIMARY KEY | - | معرف فريد للطالب (UUID) |
| `name` | TEXT | NOT NULL | - | الاسم الكامل |
| `student_id` | TEXT | NOT NULL | - | الرقم الجامعي |
| `department` | TEXT | NOT NULL | - | القسم الدراسي |
| `level` | TEXT | NOT NULL | - | المستوى الدراسي |
| `section` | TEXT | NOT NULL | - | الشعبة |
| `phone` | TEXT | NULLABLE | null | رقم الهاتف (اختياري) |
| `photo_path` | TEXT | NULLABLE | null | مسار الصورة الشخصية |
| `is_setup_complete` | INTEGER | NOT NULL | 0 | هل أكمل الإعداد؟ (0/1) |
| `is_synced` | INTEGER | NOT NULL | 0 | هل تم المزامنة؟ (0/1) |
| `created_at` | DATETIME | NULLABLE | null | تاريخ الإنشاء |
| `updated_at` | DATETIME | NULLABLE | null | تاريخ آخر تحديث |

### تعريف Drift

```dart
class StudentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get studentId => text().named('student_id')();
  TextColumn get department => text()();
  TextColumn get level => text()();
  TextColumn get section => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoPath => text().named('photo_path').nullable()();
  IntColumn get isSetupComplete => integer().named('is_setup_complete')
      .withDefault(const Constant(0))();
  IntColumn get isSynced => integer().named('is_synced')
      .withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

### مثال بيانات

| id | name | student_id | department | level | section | ... |
|----|------|------------|------------|-------|---------|-----|
| `uuid-1234` | أحمد محمد | 2024001234 | علوم الحاسب | المستوى الثالث | أ | ... |

### العمليات المتاحة

```dart
// الحصول على بيانات الطالب
Future<StudentProfile?> getStudent()

// حفظ أو تحديث بيانات الطالب
Future<void> saveStudent(StudentProfilesCompanion student)

// حذف بيانات الطالب
Future<int> deleteStudent()

// التحقق من إكمال الإعداد
Future<bool> isSetupComplete()
```

---

## 📋 جدول `attendance_history`

يخزن سجل جميع عمليات الحضور.

### مخطط الجدول

| العمود | النوع | القيود | الافتراضي | الوصف |
|--------|------|--------|-----------|-------|
| `id` | TEXT | PRIMARY KEY | - | معرف السجل الفريد |
| `session_id` | TEXT | NULLABLE | null | معرف جلسة الحضور |
| `course_name` | TEXT | NULLABLE | null | اسم المقرر |
| `date` | DATETIME | NULLABLE | null | تاريخ الحضور |
| `time` | TEXT | NULLABLE | null | وقت الحضور (HH:mm) |
| `status` | TEXT | NOT NULL | `'present'` | حالة الحضور |
| `server_response` | TEXT | NOT NULL | `''` | رسالة الخادم |
| `is_synced` | INTEGER | NOT NULL | 0 | هل تم المزامنة مع الخادم؟ (0/1) |
| `attendance_id` | TEXT | NULLABLE | null | معرف الحضور من الخادم |
| `created_at` | DATETIME | NULLABLE | null | تاريخ إنشاء السجل |

### قيم حالة الحضور (`status`)

| القيمة | الوصف | اللون |
|--------|-------|-------|
| `present` | حاضر | 🟢 أخضر |
| `absent` | غائب | 🔴 أحمر |
| `late` | متأخر | 🟠 برتقالي |
| `excused` | معذور | 🔵 أزرق |

### تعريف Drift

```dart
class AttendanceHistoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().named('session_id').nullable()();
  TextColumn get courseName => text().named('course_name').nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get time => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('present'))();
  TextColumn get serverResponse => text().named('server_response')
      .withDefault(const Constant(''))();
  IntColumn get isSynced => integer().named('is_synced')
      .withDefault(const Constant(0))();
  TextColumn get attendanceId => text().named('attendance_id').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

### مثال بيانات

| id | session_id | course_name | date | time | status | server_response | is_synced |
|----|------------|-------------|------|------|--------|-----------------|-----------|
| `att_001` | `sess_123` | هياكل البيانات | 2024-01-15 | 08:30 | present | تم تسجيل حضورك بنجاح | 1 |
| `att_002` | `sess_124` | برمجة 2 | 2024-01-16 | 09:15 | late | تم تسجيل حضورك (متأخر) | 1 |

### العمليات المتاحة

```dart
// إضافة سجل حضور
Future<void> addAttendanceRecord(AttendanceHistoryTableCompanion record)

// الحصول على جميع السجلات (الأحدث أولاً)
Future<List<AttendanceHistoryRow>> getAllAttendanceRecords({
  int? limit,
  int? offset,
})

// البحث في السجلات
Future<List<AttendanceHistoryRow>> searchAttendanceRecords({
  String? dateQuery,
  String? statusFilter,
})

// عدد السجلات
Future<int> getAttendanceCount()

// حذف جميع السجلات
Future<int> clearAttendanceHistory()
```

---

## ⚙️ جدول `settings`

يخزن إعدادات التطبيق بصيغة Key-Value.

### مخطط الجدول

| العمود | النوع | القيود | الافتراضي | الوصف |
|--------|------|--------|-----------|-------|
| `key` | TEXT | PRIMARY KEY | - | مفتاح الإعداد |
| `value` | TEXT | NOT NULL | - | قيمة الإعداد |
| `type` | TEXT | NOT NULL | `'string'` | نوع القيمة |
| `updated_at` | DATETIME | NULLABLE | null | تاريخ آخر تحديث |

### المفاتيح المستخدمة

| المفتاح (`key`) | الوصف | نوع القيمة | مثال |
|-----------------|-------|------------|-------|
| `theme_mode` | وضع العرض | string | `light`, `dark`, `system` |
| `notifications_enabled` | تفعيل الإشعارات | bool | `true`, `false` |
| `last_sync_time` | آخر مزامنة | datetime | ISO 8601 string |
| `default_server_ip` | IP الخادم الافتراضي | string | `192.168.1.100` |
| `default_server_port` | المنفذ الافتراضي | int | `8080` |
| `language` | اللغة | string | `ar`, `en` |

### أنواع القيم (`type`)

| النوع | الوصف |
|-------|-------|
| `string` | نص عادي |
| `int` | رقم صحيح |
| `bool` | قيمة منطقية (`true`/`false`) |
| `datetime` | تاريخ ووقت |

### تعريف Drift

```dart
class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get type => text().withDefault(const Constant('string'))();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
```

### مثال بيانات

| key | value | type | updated_at |
|-----|-------|------|------------|
| `theme_mode` | `dark` | string | 2024-01-15T10:00:00 |
| `notifications_enabled` | `true` | bool | 2024-01-15T10:00:00 |
| `last_sync_time` | `2024-01-15T08:30:00` | datetime | 2024-01-15T08:30:00 |

### العمليات المتاحة

```dart
// الحصول على إعداد
Future<SettingsRow?> getSetting(String key)

// حفظ إعداد
Future<void> saveSetting(SettingsTableCompanion setting)

// حذف إعداد
Future<int> deleteSetting(String key)
```

---

## 🔌 جدول `connection_logs`

يسجل جميع محاولات الاتصال بالخادم.

### مخطط الجدول

| العميد | النوع | القيود | الافتراضي | الوصف |
|--------|------|--------|-----------|-------|
| `id` | TEXT | PRIMARY KEY | - | معرف السجل الفريد |
| `ip` | TEXT | NOT NULL | - | عنوان IP المستهدف |
| `port` | INTEGER | NOT NULL | - | رقم المنفذ |
| `status` | TEXT | NOT NULL | `'pending'` | حالة الاتصال |
| `error_message` | TEXT | NULLABLE | null | رسالة الخطأ (إن وجدت) |
| `timestamp` | DATETIME | NULLABLE | null | وقت المحاولة |

### حالات الاتصال (`status`)

| القيمة | الوصف |
|--------|-------|
| `success` | اتصال ناجح |
| `failed` | فشل في الاتصال |
| `timeout` | انتهت المهلة |
| `duplicate` | تسجيل مكرر |
| `session_closed` | الجلسة مغلقة |
| `pending` | قيد الانتظار |

### تعريف Drift

```dart
class ConnectionLogsTable extends Table {
  TextColumn get id => text()();
  TextColumn get ip => text()();
  IntColumn get port => integer()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get errorMessage => text().named('error_message').nullable()();
  DateTimeColumn get timestamp => dateTime().named('timestamp').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

### مثال بيانات

| id | ip | port | status | error_message | timestamp |
|----|----|------|--------|---------------|-----------|
| `log_001` | 192.168.1.100 | 8080 | success | null | 2024-01-15T08:30:00 |
| `log_002` | 192.168.1.101 | 8080 | failed | Connection refused | 2024-01-15T09:00:00 |
| `log_003` | 192.168.1.100 | 8080 | timeout | Request timeout | 2024-01-15T10:00:00 |

### العمليات المتاحة

```dart
// إضافة سجل اتصال
Future<void> addConnectionLog(ConnectionLogsTableCompanion log)

// الحصول على سجلات الاتصالات (الأحدث أولاً)
Future<List<ConnectionLogsRow>> getConnectionLogs({int? limit})

// حذف السجلات القديمة
Future<int> cleanOldConnectionLogs({int daysToKeep = 30})
```

---

## 📊 العلاقات بين الجداول

```
┌──────────────────┐       ┌────────────────────────┐
│  student_profile │       │   attendance_history   │
│                  │       │                        │
│  id (PK)         │───┐   │  id (PK)               │
│  name            │   │   │  session_id            │
│  student_id      │   │   │  course_name           │
│  department      │   │   │  date                  │
│  level           │   │   │  time                  │
│  section         │   │   │  status                │
└──────────────────┘   │   │  created_at            │
                        │   └────────────────────────┘
                        │              │
                        │   1:N        │
                        │  (طالب له    │
                        │   عدة سجلات) │
                        │              │
┌──────────────────┐   │   ┌────────────────────────┐
│     settings     │   │   │   connection_logs      │
│                  │   │   │                        │
│  key (PK)        │   │   │  id (PK)               │
│  value           │   │   │  ip                    │
│  type            │   │   │  port                  │
└──────────────────┘   │   │  status                │
                        │   │  timestamp             │
                        │   └────────────────────────┘
                        │
                        │   لا توجد علاقات مباشرة
                        │   (جداول مستقلة)
```

---

## 🔧 العمليات المتاحة

### عمليات الطالب

```dart
class AppDatabase extends _$AppDatabase {
  // ==================== عمليات الطالب ====================
  
  /// الحصول على بيانات الطالب
  Future<StudentProfile?> getStudent()
  
  /// حفظ أو تحديث بيانات الطالب
  Future<void> saveStudent(StudentProfilesCompanion student)
  
  /// حذف بيانات الطالب
  Future<int> deleteStudent()
  
  /// التحقق من إكمال الإعداد
  Future<bool> isSetupComplete()
}
```

### عمليات الحضور

```dart
class AppDatabase extends _$AppDatabase {
  // ==================== عمليات الحضور ====================
  
  /// إضافة سجل حضور
  Future<void> addAttendanceRecord(AttendanceHistoryTableCompanion record)
  
  /// الحصول على جميع سجلات الحضور
  Future<List<AttendanceHistoryRow>> getAllAttendanceRecords({
    int? limit,
    int? offset,
  })
  
  /// البحث في سجلات الحضور
  Future<List<AttendanceHistoryRow>> searchAttendanceRecords({
    String? dateQuery,
    String? statusFilter,
  })
  
  /// الحصول على عدد سجلات الحضور
  Future<int> getAttendanceCount()
  
  /// حذف جميع سجلات الحضور
  Future<int> clearAttendanceHistory()
}
```

### عمليات الإعدادات

```dart
class AppDatabase extends _$AppDatabase {
  // ==================== عمليات الإعدادات ====================
  
  /// الحصول على إعداد
  Future<SettingsRow?> getSetting(String key)
  
  /// حفظ إعداد
  Future<void> saveSetting(SettingsTableCompanion setting)
  
  /// حذف إعداد
  Future<int> deleteSetting(String key)
}
```

### عمليات سجل الاتصالات

```dart
class AppDatabase extends _$AppDatabase {
  // ==================== عمليات سجل الاتصالات ====================
  
  /// إضافة سجل اتصال
  Future<void> addConnectionLog(ConnectionLogsTableCompanion log)
  
  /// الحصول على سجلات الاتصالات
  Future<List<ConnectionLogsRow>> getConnectionLogs({int? limit})
  
  /// حذف السجلات القديمة (> 30 يوم)
  Future<int> cleanOldConnectionLogs({int daysToKeep = 30})
}
```

### عمليات عامة

```dart
class AppDatabase extends _$AppDatabase {
  // ==================== عمليات عامة ====================
  
  /// مسح جميع البيانات (في transaction واحد)
  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(studentProfiles).go();
      await delete(attendanceHistoryTable).go();
      await delete(settingsTable).go();
      await delete(connectionLogsTable).go();
    });
  }
}
```

---

## 📁 موقع ملف قاعدة البيانات

### Android

```
/data/data/com.example.attendance_student/databases/attendance_student.db
```

### iOS

```
/Library/Application Support/default/attendance_student.db
```

### الوصول عبر الكود

```dart
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'attendance_student.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

### تصدير قاعدة البيانات (للتصحيح)

```dart
// نسخ قاعدة البيانات لمجلد خارجي
import 'dart:io';

Future<String> exportDatabase() async {
  final dbFile = File('/path/to/attendance_student.db');
  final exportDir = await getExternalStorageDirectory();
  final exportedFile = await dbFile.copy(
    '${exportDir.path}/exported_database_${DateTime.now().millisecondsSinceEpoch}.db'
  );
  return exportedFile.path;
}
```

---

## 🔄 الترحيل (Migrations)

### الإصدار الحالي

```dart
@override
int get schemaVersion => AppConstants.databaseVersion; // = 1
```

### كيفية إضافة ترحيل جديد

```dart
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // زيادة الرقم
  
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // ترحيل من الإصدار 1 إلى 2
          // مثال: إضافة عمود جديد
          // await m.addColumn(table, table.newColumn);
        }
        if (from < 3) {
          // ترحيل من الإصدار 2 إلى 3
        }
      },
    );
  }
}
```

### أمثلة على الترحيل الشائع

```dart
// إضافة عمود جديد
await m.addColumn(studentProfiles, studentProfiles.email);

// حذف عمود (غير مدعوم مباشرة - يتطلب إنشاء جدول جديد)
// 1. إنشاء جدول جديد بدون العمود
// 2. نسخ البيانات
// 3. حذف الجدول القديم
// 4. إعادة تسمية الجديد

// تغيير نوع عمود
// نفس خطوات الحذف + الإنشاء

// إضافة جدول جديد
await m.createTable(newTable);

// إنشاء index
await m.create(customIndex);
```

---

## 📈 أداء قاعدة البيانات

### نصائح التحسين

1. **استخدام Indexes** للبحث المتكرر:
```dart
@DriftDatabase(tables: [...], daos: [...])
class AppDatabase extends _$AppDatabase {
  // إضافة Index للتاريخ في سجل الحضور
  // يمكن عمل ذلك عبر customStatement
}
```

2. **تحديد LIMIT** في الاستعلامات:
```dart
select(attendanceHistoryTable)..limit(50);
```

3. **استخدام Transactions** للعمليات المتعددة:
```dart
await transaction(() async {
  // عدة عمليات هنا
});
```

4. **تنظيف البيانات القديمة** دورياً:
```dart
cleanOldConnectionLogs(daysToKeep: 30);
```

---

## 🔒 النسخ الاحتياطي والاستعادة

### إنشاء نسخة احتياطية

```dart
Future<File> backupDatabase() async {
  final dbFile = File(p.join(
    (await getApplicationDocumentsDirectory()).path,
    'attendance_student.db',
  ));
  
  final backupDir = await getTemporaryDirectory();
  final backupFile = File(p.join(
    backupDir.path,
    'backup_${DateTime.now().millisecondsSinceEpoch}.db',
  ));
  
  return await dbFile.copy(backupFile.path);
}
```

### استعادة من نسخة احتياطية

```dart
Future<void> restoreDatabase(File backupFile) async {
  final dbPath = p.join(
    (await getApplicationDocumentsDirectory()).path,
    'attendance_student.db',
  );
  
  // يجب إغلاق قاعدة البيانات أولاً
  // ثم نسخ الملف
  await backupFile.copy(dbPath);
}
```

---

## 🛠️ أدوات التصحيح

### عرض محتويات قاعدة البيانات

يمكن استخدام أدوات مثل:

1. **DB Browser for SQLite** (Desktop)
2. **Android Device Explorer** (Android Studio)
3. **Stetho** (Chrome DevTools)

### تفعيل Logging في Drift

```dart
AppDatabase() : super(_openConnection(), logStatements: true);
```

---

<p align="center">
  <strong>🗄️ آخر تحديث: يناير 2024</strong>
</p>
