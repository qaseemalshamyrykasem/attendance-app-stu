/// قاعدة البيانات الرئيسية - Drift/SQLite
library;

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../core/constants/app_constants.dart';

part 'local_database.g.dart';

// ==================== الجداول ====================

/// جدول بيانات الطالب
class StudentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get studentId => text().named('student_id')();
  TextColumn get department => text()();
  TextColumn get level => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoPath => text().named('photo_path').nullable()();
  IntColumn get isSetupComplete => integer().named('is_setup_complete').withDefault(const Constant(0))();
  IntColumn get isSynced => integer().named('is_synced').withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول سجل الحضور
class AttendanceHistoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().named('session_id').nullable()();
  TextColumn get courseName => text().named('course_name').nullable()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get time => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('present'))();
  TextColumn get serverResponse => text().named('server_response').withDefault(const Constant(''))();
  IntColumn get isSynced => integer().named('is_synced').withDefault(const Constant(0))();
  TextColumn get attendanceId => text().named('attendance_id').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// جدول الإعدادات
class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get type => text().withDefault(const Constant('string'))();
  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

/// جدول سجل الاتصالات
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

// ==================== قاعدة البيانات ====================

@DriftDatabase(tables: [
  StudentProfiles,
  AttendanceHistoryTable,
  SettingsTable,
  ConnectionLogsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  // ==================== عمليات الطالب ====================

  /// الحصول على بيانات الطالب
  Future<StudentProfile?> getStudent() async {
    final query = select(studentProfiles).getSingleOrNull();
    return query;
  }

  /// حفظ أو تحديث بيانات الطالب
  Future<void> saveStudent(StudentProfilesCompanion student) async {
    await into(studentProfiles).insertOnConflictUpdate(student);
  }

  /// حذف بيانات الطالب
  Future<int> deleteStudent() async {
    return await delete(studentProfiles).go();
  }

  /// التحقق من إكمال الإعداد
  Future<bool> isSetupComplete() async {
    final student = await getStudent();
    return student?.isSetupComplete == 1;
  }

  // ==================== عمليات الحضور ====================

  /// إضافة سجل حضور
  Future<void> addAttendanceRecord(AttendanceHistoryTableCompanion record) async {
    await into(attendanceHistoryTable).insert(record);
  }

  /// الحصول على جميع سجلات الحضور (الأحدث أولاً)
  Future<List<AttendanceHistoryTableData>> getAllAttendanceRecords({
    int? limit,
    int? offset,
  }) async {
    var query = select(attendanceHistoryTable)
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
      ]);
    
    if (limit != null) {
      query = query..limit(limit, offset: offset);
    }
    
    return query.get();
  }

  /// البحث في سجلات الحضور
  Future<List<AttendanceHistoryTableData>> searchAttendanceRecords({
    String? dateQuery,
    String? statusFilter,
  }) async {
    var query = select(attendanceHistoryTable);

    if (statusFilter != null && statusFilter.isNotEmpty) {
      query.where((t) => t.status.equals(statusFilter));
    }

    query.orderBy([
      (t) => OrderingTerm.desc(t.createdAt),
    ]);

    return query.get();
  }

  /// الحصول على عدد سجلات الحضور
  Future<int> getAttendanceCount() async {
    final count = attendanceHistoryTable.id.count();
    final query = selectOnly(attendanceHistoryTable)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  /// حذف جميع سجلات الحضور
  Future<int> clearAttendanceHistory() async {
    return await delete(attendanceHistoryTable).go();
  }

  // ==================== عمليات الإعدادات ====================

  /// الحصول على إعداد
  Future<SettingsTableData?> getSetting(String key) async {
    final query = select(settingsTable)
      ..where((t) => t.key.equals(key));
    return query.getSingleOrNull();
  }

  /// حفظ إعداد
  Future<void> saveSetting(SettingsTableCompanion setting) async {
    await into(settingsTable).insertOnConflictUpdate(setting);
  }

  /// حذف إعداد
  Future<int> deleteSetting(String key) async {
    return (delete(settingsTable)..where((t) => t.key.equals(key))).go();
  }

  // ==================== عمليات سجل الاتصالات ====================

  /// إضافة سجل اتصال
  Future<void> addConnectionLog(ConnectionLogsTableCompanion log) async {
    await into(connectionLogsTable).insert(log);
  }

  /// الحصول على سجلات الاتصالات (الأحدث أولاً)
  Future<List<ConnectionLogsTableData>> getConnectionLogs({int? limit}) async {
    var query = select(connectionLogsTable)
      ..orderBy([
        (t) => OrderingTerm.desc(t.timestamp),
      ]);
    
    if (limit != null) {
      query = query..limit(limit);
    }
    
    return query.get();
  }

  /// حذف سجلات الاتصالات القديمة
  Future<int> cleanOldConnectionLogs({int daysToKeep = 30}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
    return (delete(connectionLogsTable)..where(
      (t) => t.timestamp.isSmallerThanValue(cutoffDate),
    )).go();
  }

  // ==================== عمليات عامة ====================

  /// مسح جميع البيانات
  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(studentProfiles).go();
      await delete(attendanceHistoryTable).go();
      await delete(settingsTable).go();
      await delete(connectionLogsTable).go();
    });
  }
}

/// فتح اتصال قاعدة البيانات
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseName));
    return NativeDatabase.createInBackground(file);
  });
}
