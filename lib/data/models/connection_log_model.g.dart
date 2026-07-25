// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionLogModelImpl _$$ConnectionLogModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionLogModelImpl(
      id: json['id'] as String,
      ip: json['ip'] as String,
      port: (json['port'] as num).toInt(),
      status: json['status'] as String? ?? 'pending',
      errorMessage: json['errorMessage'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ConnectionLogModelImplToJson(
        _$ConnectionLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ip': instance.ip,
      'port': instance.port,
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
