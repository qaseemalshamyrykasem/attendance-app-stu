/// واجهة مخزن بيانات الحضور
library;

import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  /// إرسال بيانات الحضور
  Future<AttendanceEntity> submitAttendance({
    required String ip,
    required int port,
    required String sessionId,
    String? sessionToken,
    required Map<String, dynamic> studentData,
  });

  /// الحصول على سجل الحضور
  Future<List<AttendanceEntity>> getAttendanceHistory({
    int? limit,
    int? offset,
  });

  /// البحث في سجلات الحضور
  Future<List<AttendanceEntity>> searchAttendanceRecords({
    String? dateQuery,
    String? statusFilter,
  });

  /// البحث بالحالة فقط (للسجل)
  Future<List<AttendanceEntity>> searchRecords({String? statusFilter});

  /// الحصول على عدد سجلات الحضور
  Future<int> getAttendanceCount();

  /// مسح سجل الحضور
  Future<void> clearHistory();
}
