/// نموذج بيانات الحضور
library;

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String id,
    String? sessionId,
    String? courseName,
    DateTime? date,
    String? time,
    @Default('present') String status,
    @Default('') String serverResponse,
    @Default(false) bool isSynced,
    String? attendanceId,
    DateTime? createdAt,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  /// إنشاء نموذج فارغ
  factory AttendanceModel.empty() => const AttendanceModel(
        id: '',
      );

  /// إنشاء نموذج من استجابة الخادم
  factory AttendanceModel.fromServerResponse({
    required String sessionId,
    required String courseName,
    required String status,
    required String message,
    String? attendanceId,
  }) =>
      AttendanceModel(
        id: _generateId(),
        sessionId: sessionId,
        courseName: courseName,
        date: DateTime.now(),
        time: _getCurrentTime(),
        status: status,
        serverResponse: message,
        isSynced: true,
        attendanceId: attendanceId,
        createdAt: DateTime.now(),
      );
}

String _generateId() {
  return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
}

String _getCurrentTime() {
  final now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
}

/// امتداد لتحويل النموذج إلى Map للقاعدة البيانات
extension AttendanceModelExtension on AttendanceModel {
  Map<String, dynamic> toDbMap() => {
        'id': id,
        'session_id': sessionId,
        'course_name': courseName,
        'date': date?.toIso8601String().split('T').first,
        'time': time,
        'status': status,
        'server_response': serverResponse,
        'is_synced': isSynced ? 1 : 0,
        'attendance_id': attendanceId,
        'created_at': createdAt?.toIso8601String(),
      };

  static AttendanceModel fromDbMap(Map<String, dynamic> map) => AttendanceModel(
        id: map['id'] as String,
        sessionId: map['session_id'] as String?,
        courseName: map['course_name'] as String?,
        date: map['date'] != null
            ? DateTime.tryParse(map['date'] as String)
            : null,
        time: map['time'] as String?,
        status: (map['status'] as String?) ?? 'present',
        serverResponse: (map['server_response'] as String?) ?? '',
        isSynced: (map['is_synced'] as int?) == 1,
        attendanceId: map['attendance_id'] as String?,
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'] as String)
            : null,
      );
}

/// أنواع حالة الحضور
enum AttendanceStatus {
  present('حاضر', 'present'),
  absent('غائب', 'absent'),
  late('متأخر', 'late'),
  excused('معذور', 'excused');

  final String arabicName;
  final String value;
  
  const AttendanceStatus(this.arabicName, this.value);
}

/// الحصول على اللون حسب الحالة
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'present':
      return const Color(0xFF4CAF50);
    case 'absent':
      return const Color(0xFFF44336);
    case 'late':
      return const Color(0xFFFF9800);
    case 'excused':
      return const Color(0xFF2196F3);
    default:
      return const Color(0xFF9E9E9E);
  }
}
