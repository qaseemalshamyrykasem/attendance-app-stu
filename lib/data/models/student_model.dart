/// نموذج بيانات الطالب
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_model.freezed.dart';
part 'student_model.g.dart';

@freezed
class StudentModel with _$StudentModel {
  const factory StudentModel({
    required String id,
    required String name,
    required String studentId,
    required String department,
    required String level,
    required String section,
    String? phone,
    String? photoPath,
    @Default(false) bool isSetupComplete,
    @Default(false) bool isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StudentModel;

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  /// إنشاء نموذج فارغ
  factory StudentModel.empty() => const StudentModel(
        id: '',
        name: '',
        studentId: '',
        department: '',
        level: '',
        section: '',
      );
}

/// امتداد لتحويل النموذج إلى Map للقاعدة البيانات
extension StudentModelExtension on StudentModel {
  Map<String, dynamic> toDbMap() => {
        'id': id,
        'name': name,
        'student_id': studentId,
        'department': department,
        'level': level,
        'section': section,
        'phone': phone,
        'photo_path': photoPath,
        'is_setup_complete': isSetupComplete ? 1 : 0,
        'is_synced': isSynced ? 1 : 0,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  static StudentModel fromDbMap(Map<String, dynamic> map) => StudentModel(
        id: map['id'] as String,
        name: map['name'] as String,
        studentId: map['student_id'] as String,
        department: map['department'] as String,
        level: map['level'] as String,
        section: map['section'] as String,
        phone: map['phone'] as String?,
        photoPath: map['photo_path'] as String?,
        isSetupComplete: (map['is_setup_complete'] as int?) == 1,
        isSynced: (map['is_synced'] as int?) == 1,
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'] as String)
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.tryParse(map['updated_at'] as String)
            : null,
      );
}
