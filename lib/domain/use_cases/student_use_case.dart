/// حالات استخدام الطالب
library;

import '../../data/models/student_model.dart';
import '../repositories/student_repository.dart';

/// حالة استخدام الحصول على بيانات الطالب
class GetStudentUseCase {
  final StudentRepository _repository;

  GetStudentUseCase(this._repository);

  Future<StudentModel?> call() async {
    return await _repository.getStudent();
  }
}

/// حالة استخدام حفظ بيانات الطالب
class SaveStudentUseCase {
  final StudentRepository _repository;

  SaveStudentUseCase(this._repository);

  Future<StudentModel> call({
    required String name,
    required String studentId,
    required String department,
    required String level,
    required String section,
    String? phone,
    String? photoPath,
  }) async {
    final student = StudentModel(
      id: _generateId(),
      name: name,
      studentId: studentId,
      department: department,
      level: level,
      section: section,
      phone: phone,
      photoPath: photoPath,
    );
    
    return await _repository.saveStudent(student);
  }

  String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
}

/// حالة استخدام تحديث بيانات الطالب
class UpdateStudentUseCase {
  final StudentRepository _repository;

  UpdateStudentUseCase(this._repository);

  Future<StudentModel> call(StudentModel student) async {
    return await _repository.updateStudent(student);
  }
}

/// حالة استخدام حذف بيانات الطالب
class DeleteStudentUseCase {
  final StudentRepository _repository;

  DeleteStudentUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.deleteStudent();
  }
}

/// حالة استخدام التحقق من إكمال الإعداد
class IsSetupCompleteUseCase {
  final StudentRepository _repository;

  IsSetupCompleteUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isSetupComplete();
  }
}
