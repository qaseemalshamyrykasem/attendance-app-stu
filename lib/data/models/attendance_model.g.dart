// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceModelImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String?,
      courseName: json['courseName'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      status: json['status'] as String? ?? 'present',
      serverResponse: json['serverResponse'] as String? ?? '',
      isSynced: json['isSynced'] as bool? ?? false,
      attendanceId: json['attendanceId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AttendanceModelImplToJson(
        _$AttendanceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'courseName': instance.courseName,
      'date': instance.date?.toIso8601String(),
      'time': instance.time,
      'status': instance.status,
      'serverResponse': instance.serverResponse,
      'isSynced': instance.isSynced,
      'attendanceId': instance.attendanceId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
