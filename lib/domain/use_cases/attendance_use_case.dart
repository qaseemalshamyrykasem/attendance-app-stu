/// حالات استخدام الحضور
library;

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// حالة استخدام إرسال الحضور
class SubmitAttendanceUseCase {
  final AttendanceRepository _repository;

  SubmitAttendanceUseCase(this._repository);

  Future<AttendanceEntity> call({
    required String ip,
    required int port,
    required String sessionId,
    required Map<String, dynamic> studentData,
  }) async {
    return await _repository.submitAttendance(
      ip: ip,
      port: port,
      sessionId: sessionId,
      studentData: studentData,
    );
  }
}

/// حالة استخدام الحصول على سجل الحضور
class GetAttendanceHistoryUseCase {
  final AttendanceRepository _repository;

  GetAttendanceHistoryUseCase(this._repository);

  Future<List<AttendanceEntity>> call({
    int? limit,
    int? offset,
  }) async {
    return await _repository.getAttendanceHistory(
      limit: limit,
      offset: offset,
    );
  }
}

/// حالة استخدام البحث في السجلات
class SearchAttendanceRecordsUseCase {
  final AttendanceRepository _repository;

  SearchAttendanceRecordsUseCase(this._repository);

  Future<List<AttendanceEntity>> call({
    String? statusFilter,
  }) async {
    return await _repository.searchRecords(statusFilter: statusFilter);
  }
}

/// حالة استخدام الحصول على عدد السجلات
class GetAttendanceCountUseCase {
  final AttendanceRepository _repository;

  GetAttendanceCountUseCase(this._repository);

  Future<int> call() async {
    return await _repository.getAttendanceCount();
  }
}

/// حالة استخدام مسح السجل
class ClearAttendanceHistoryUseCase {
  final AttendanceRepository _repository;

  ClearAttendanceHistoryUseCase(this._repository);

  Future<void> call() async {
    await _repository.clearHistory();
  }
}
