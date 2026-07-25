/// كيان الطالب
library;

class StudentEntity {
  final String id;
  final String name;
  final String studentId;
  final String department;
  final String level;
  final String section;
  final String? phone;
  final String? photoPath;
  final bool isSetupComplete;
  final bool isSynced;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.studentId,
    required this.department,
    required this.level,
    required this.section,
    this.phone,
    this.photoPath,
    this.isSetupComplete = false,
    this.isSynced = false,
    this.createdAt,
    this.updatedAt,
  });

  /// إنشاء كيان فارغ
  factory StudentEntity.empty() => const StudentEntity(
        id: '',
        name: '',
        studentId: '',
        department: '',
        level: '',
        section: '',
      );

  /// نسخ مع تعديل
  StudentEntity copyWith({
    String? id,
    String? name,
    String? studentId,
    String? department,
    String? level,
    String? section,
    String? phone,
    String? photoPath,
    bool? isSetupComplete,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      studentId: studentId ?? this.studentId,
      department: department ?? this.department,
      level: level ?? this.level,
      section: section ?? this.section,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
      isSetupComplete: isSetupComplete ?? this.isSetupComplete,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// التحقق من صحة البيانات الأساسية
  bool get isValid =>
      name.isNotEmpty &&
      studentId.isNotEmpty &&
      department.isNotEmpty &&
      level.isNotEmpty &&
      section.isNotEmpty;

  /// الحصول على الأحرف الأولى من الاسم للأفاتار
  String get initials {
    if (name.isEmpty) return '??';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return name.length >= 2 ? name.substring(0, 2) : name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
