import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<AttendanceEntity> submitAttendance({
    required String ip,
    required int port,
    required String sessionId,
    String? sessionToken, // تم إضافته حسب الخطة
    required Map<String, dynamic> studentData,
  });

  Future<List<AttendanceEntity>> getAttendanceHistory({int? limit, int? offset});
  Future<List<AttendanceEntity>> searchAttendanceRecords({String? dateQuery, String? statusFilter});
  Future<List<AttendanceEntity>> searchRecords({String? statusFilter});
  Future<int> getAttendanceCount();
  Future<void> clearHistory();
}
