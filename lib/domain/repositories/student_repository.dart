/// واجهة مخزن بيانات الطالب
library;

import '../../data/models/student_model.dart';
import '../entities/student_entity.dart';

abstract class StudentRepository {
  /// الحصول على بيانات الطالب
  Future<StudentModel?> getStudent();

  /// حفظ بيانات طالب جديد
  Future<StudentModel> saveStudent(StudentModel student);

  /// تحديث بيانات الطالب
  Future<StudentModel> updateStudent(StudentModel student);

  /// حذف بيانات الطالب
  Future<bool> deleteStudent();

  /// التحقق من إكمال الإعداد الأولي
  Future<bool> isSetupComplete();

  /// مسح جميع البيانات
  Future<void> clearAllData();
}
