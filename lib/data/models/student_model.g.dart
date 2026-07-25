// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentModelImpl _$$StudentModelImplFromJson(Map<String, dynamic> json) =>
    _$StudentModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      studentId: json['studentId'] as String,
      department: json['department'] as String,
      level: json['level'] as String,
      section: json['section'] as String,
      phone: json['phone'] as String?,
      photoPath: json['photoPath'] as String?,
      isSetupComplete: json['isSetupComplete'] as bool? ?? false,
      isSynced: json['isSynced'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StudentModelImplToJson(_$StudentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'studentId': instance.studentId,
      'department': instance.department,
      'level': instance.level,
      'section': instance.section,
      'phone': instance.phone,
      'photoPath': instance.photoPath,
      'isSetupComplete': instance.isSetupComplete,
      'isSynced': instance.isSynced,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
