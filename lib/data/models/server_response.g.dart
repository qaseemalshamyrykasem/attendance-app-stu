// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerResponseImpl _$$ServerResponseImplFromJson(Map<String, dynamic> json) =>
    _$ServerResponseImpl(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      attendanceId: json['attendanceId'] as String?,
      sessionId: json['sessionId'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      data: json['data'] ?? null,
    );

Map<String, dynamic> _$$ServerResponseImplToJson(
        _$ServerResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'attendanceId': instance.attendanceId,
      'sessionId': instance.sessionId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'data': instance.data,
    };

_$AttendanceRequestImpl _$$AttendanceRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRequestImpl(
      studentId: json['studentId'] as String,
      name: json['name'] as String,
      department: json['department'] as String,
      level: json['level'] as String,
      section: json['section'] as String,
      deviceId: json['deviceId'] as String,
      timestamp: json['timestamp'] as String,
      hash: json['hash'] as String,
      sessionId: json['sessionId'] as String?,
      sessionToken: json['sessionToken'] as String?,
    );

Map<String, dynamic> _$$AttendanceRequestImplToJson(
        _$AttendanceRequestImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'name': instance.name,
      'department': instance.department,
      'level': instance.level,
      'section': instance.section,
      'deviceId': instance.deviceId,
      'timestamp': instance.timestamp,
      'hash': instance.hash,
      'sessionId': instance.sessionId,
      'sessionToken': instance.sessionToken,
    };

_$QrCodeDataImpl _$$QrCodeDataImplFromJson(Map<String, dynamic> json) =>
    _$QrCodeDataImpl(
      ip: json['ip'] as String,
      port: (json['port'] as num).toInt(),
      sessionId: json['sessionId'] as String,
      sessionToken: json['sessionToken'] as String?,
    );

Map<String, dynamic> _$$QrCodeDataImplToJson(_$QrCodeDataImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'port': instance.port,
      'sessionId': instance.sessionId,
      'sessionToken': instance.sessionToken,
    };
