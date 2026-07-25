/// كيان الحضور
library;

class AttendanceEntity {
  final String id;
  final String? sessionId;
  final String? courseName;
  final DateTime date;
  final String time;
  final String status;
  final String message;
  final bool isSuccess;

  const AttendanceEntity({
    required this.id,
    this.sessionId,
    this.courseName,
    required this.date,
    this.time = '',
    this.status = 'present',
    this.message = '',
    this.isSuccess = false,
  });

  /// إنشاء كيان فارغ
  factory AttendanceEntity.empty() => AttendanceEntity(
        id: '',
        date: DateTime.now(),
      );

  /// نسخ مع تعديل
  AttendanceEntity copyWith({
    String? id,
    String? sessionId,
    String? courseName,
    DateTime? date,
    String? time,
    String? status,
    String? message,
    bool? isSuccess,
  }) {
    return AttendanceEntity(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      courseName: courseName ?? this.courseName,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  /// التحقق من النجاح
  bool get isSuccessful => isSuccess && status == 'present';

  /// حالة الحضور كنص عربي
  String get statusArabic {
    switch (status.toLowerCase()) {
      case 'present':
        return 'حاضر';
      case 'absent':
        return 'غائب';
      case 'late':
        return 'متأخر';
      case 'excused':
        return 'معذور';
      case 'failed':
        return 'فاشل';
      default:
        return 'غير محدد';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
