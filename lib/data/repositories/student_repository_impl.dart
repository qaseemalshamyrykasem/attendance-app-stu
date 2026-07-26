/// تنفيذ مخزن بيانات الطالب
library;

import 'package:drift/drift.dart';
import '../../core/constants/app_constants.dart';
import '../../data/data_sources/local/local_database.dart';
import '../../data/data_sources/local/hive_service.dart';
import '../../data/data_sources/local/shared_prefs_service.dart';
import '../../data/models/student_model.dart';
import '../../../domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final AppDatabase _database;
  final HiveService _hive;
  final SharedPrefsService _prefs;

  StudentRepositoryImpl({
    required AppDatabase database,
    required HiveService hive,
    required SharedPrefsService prefs,
  })  : _database = database,
        _hive = hive,
        _prefs = prefs;

  @override
  Future<StudentModel?> getStudent() async {
    final studentRow = await _database.getStudent();
    if (studentRow == null) return null;
    
    return StudentModel(
      id: studentRow.id,
      name: studentRow.name,
      studentId: studentRow.studentId,
      department: studentRow.department,
      level: studentRow.level,
      phone: studentRow.phone,
      photoPath: studentRow.photoPath,
      isSetupComplete: studentRow.isSetupComplete == 1,
      isSynced: studentRow.isSynced == 1,
      createdAt: studentRow.createdAt,
      updatedAt: studentRow.updatedAt,
    );
  }

  @override
  Future<StudentModel> saveStudent(StudentModel student) async {
    final now = DateTime.now();
    final studentToSave = student.copyWith(
      createdAt: student.createdAt ?? now,
      updatedAt: now,
      isSetupComplete: true,
    );

    await _database.saveStudent(StudentProfilesCompanion(
      id: Value(studentToSave.id),
      name: Value(studentToSave.name),
      studentId: Value(studentToSave.studentId),
      department: Value(studentToSave.department),
      level: Value(studentToSave.level),
      phone: Value(studentToSave.phone),
      photoPath: Value(studentToSave.photoPath),
      isSetupComplete: const Value(1),
      isSynced: Value(studentToSave.isSynced ? 1 : 0),
      createdAt: Value(studentToSave.createdAt),
      updatedAt: Value(now),
    ));

    // تحديث SharedPreferences
    await _prefs.setSetupComplete(true);
    await _prefs.setStudentId(student.studentId);

    // حفظ في Hive للتخزين السريع
    await _hive.setSetting(AppConstants.keyStudentId, student.studentId);

    return studentToSave;
  }

  @override
  Future<StudentModel> updateStudent(StudentModel student) async {
    final now = DateTime.now();
    final updatedStudent = student.copyWith(updatedAt: now);

    await _database.saveStudent(StudentProfilesCompanion(
      id: Value(updatedStudent.id),
      name: Value(updatedStudent.name),
      studentId: Value(updatedStudent.studentId),
      department: Value(updatedStudent.department),
      level: Value(updatedStudent.level),
      phone: Value(updatedStudent.phone),
      photoPath: Value(updatedStudent.photoPath),
      isSetupComplete: Value(updatedStudent.isSetupComplete ? 1 : 0),
      isSynced: Value(updatedStudent.isSynced ? 1 : 0),
      createdAt: Value(updatedStudent.createdAt),
      updatedAt: Value(now),
    ));

    return updatedStudent;
  }

  @override
  Future<bool> deleteStudent() async {
    try {
      await _database.deleteStudent();
      await _prefs.setSetupComplete(false);
      await _prefs.remove(AppConstants.keyStudentId);
      await _hive.removeSetting(AppConstants.keyStudentId);
      return true;
    } catch (e) {
      throw Exception('فشل في حذف بيانات الطالب');
    }
  }

  @override
  Future<bool> isSetupComplete() async {
    // التحقق من SharedPreferences أولاً (أسرع)
    if (await _prefs.isSetupComplete()) {
      return true;
    }
    
    // التحقق من قاعدة البيانات
    return await _database.isSetupComplete();
  }

  @override
  Future<void> clearAllData() async {
    await _database.deleteStudent();
    await _prefs.clearAll();
    await _hive.clearCache();
  }
}
