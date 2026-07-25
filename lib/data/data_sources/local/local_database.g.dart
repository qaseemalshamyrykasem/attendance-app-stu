// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $StudentProfilesTable extends StudentProfiles
    with TableInfo<$StudentProfilesTable, StudentProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
      'student_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _departmentMeta =
      const VerificationMeta('department');
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
      'department', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSetupCompleteMeta =
      const VerificationMeta('isSetupComplete');
  @override
  late final GeneratedColumn<int> isSetupComplete = GeneratedColumn<int>(
      'is_setup_complete', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        studentId,
        department,
        level,
        section,
        phone,
        photoPath,
        isSetupComplete,
        isSynced,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<StudentProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
          _departmentMeta,
          department.isAcceptableOrUnknown(
              data['department']!, _departmentMeta));
    } else if (isInserting) {
      context.missing(_departmentMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('is_setup_complete')) {
      context.handle(
          _isSetupCompleteMeta,
          isSetupComplete.isAcceptableOrUnknown(
              data['is_setup_complete']!, _isSetupCompleteMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_id'])!,
      department: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}department'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      isSetupComplete: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_setup_complete'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfile extends DataClass implements Insertable<StudentProfile> {
  final String id;
  final String name;
  final String studentId;
  final String department;
  final String level;
  final String section;
  final String? phone;
  final String? photoPath;
  final int isSetupComplete;
  final int isSynced;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const StudentProfile(
      {required this.id,
      required this.name,
      required this.studentId,
      required this.department,
      required this.level,
      required this.section,
      this.phone,
      this.photoPath,
      required this.isSetupComplete,
      required this.isSynced,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['student_id'] = Variable<String>(studentId);
    map['department'] = Variable<String>(department);
    map['level'] = Variable<String>(level);
    map['section'] = Variable<String>(section);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['is_setup_complete'] = Variable<int>(isSetupComplete);
    map['is_synced'] = Variable<int>(isSynced);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      name: Value(name),
      studentId: Value(studentId),
      department: Value(department),
      level: Value(level),
      section: Value(section),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      isSetupComplete: Value(isSetupComplete),
      isSynced: Value(isSynced),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory StudentProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      studentId: serializer.fromJson<String>(json['studentId']),
      department: serializer.fromJson<String>(json['department']),
      level: serializer.fromJson<String>(json['level']),
      section: serializer.fromJson<String>(json['section']),
      phone: serializer.fromJson<String?>(json['phone']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      isSetupComplete: serializer.fromJson<int>(json['isSetupComplete']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'studentId': serializer.toJson<String>(studentId),
      'department': serializer.toJson<String>(department),
      'level': serializer.toJson<String>(level),
      'section': serializer.toJson<String>(section),
      'phone': serializer.toJson<String?>(phone),
      'photoPath': serializer.toJson<String?>(photoPath),
      'isSetupComplete': serializer.toJson<int>(isSetupComplete),
      'isSynced': serializer.toJson<int>(isSynced),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  StudentProfile copyWith(
          {String? id,
          String? name,
          String? studentId,
          String? department,
          String? level,
          String? section,
          Value<String?> phone = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          int? isSetupComplete,
          int? isSynced,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      StudentProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        studentId: studentId ?? this.studentId,
        department: department ?? this.department,
        level: level ?? this.level,
        section: section ?? this.section,
        phone: phone.present ? phone.value : this.phone,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        isSetupComplete: isSetupComplete ?? this.isSetupComplete,
        isSynced: isSynced ?? this.isSynced,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  StudentProfile copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      department:
          data.department.present ? data.department.value : this.department,
      level: data.level.present ? data.level.value : this.level,
      section: data.section.present ? data.section.value : this.section,
      phone: data.phone.present ? data.phone.value : this.phone,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isSetupComplete: data.isSetupComplete.present
          ? data.isSetupComplete.value
          : this.isSetupComplete,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('studentId: $studentId, ')
          ..write('department: $department, ')
          ..write('level: $level, ')
          ..write('section: $section, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSetupComplete: $isSetupComplete, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      studentId,
      department,
      level,
      section,
      phone,
      photoPath,
      isSetupComplete,
      isSynced,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.studentId == this.studentId &&
          other.department == this.department &&
          other.level == this.level &&
          other.section == this.section &&
          other.phone == this.phone &&
          other.photoPath == this.photoPath &&
          other.isSetupComplete == this.isSetupComplete &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> studentId;
  final Value<String> department;
  final Value<String> level;
  final Value<String> section;
  final Value<String?> phone;
  final Value<String?> photoPath;
  final Value<int> isSetupComplete;
  final Value<int> isSynced;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.studentId = const Value.absent(),
    this.department = const Value.absent(),
    this.level = const Value.absent(),
    this.section = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSetupComplete = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    required String id,
    required String name,
    required String studentId,
    required String department,
    required String level,
    required String section,
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSetupComplete = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        studentId = Value(studentId),
        department = Value(department),
        level = Value(level),
        section = Value(section);
  static Insertable<StudentProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? studentId,
    Expression<String>? department,
    Expression<String>? level,
    Expression<String>? section,
    Expression<String>? phone,
    Expression<String>? photoPath,
    Expression<int>? isSetupComplete,
    Expression<int>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (studentId != null) 'student_id': studentId,
      if (department != null) 'department': department,
      if (level != null) 'level': level,
      if (section != null) 'section': section,
      if (phone != null) 'phone': phone,
      if (photoPath != null) 'photo_path': photoPath,
      if (isSetupComplete != null) 'is_setup_complete': isSetupComplete,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? studentId,
      Value<String>? department,
      Value<String>? level,
      Value<String>? section,
      Value<String?>? phone,
      Value<String?>? photoPath,
      Value<int>? isSetupComplete,
      Value<int>? isSynced,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return StudentProfilesCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isSetupComplete.present) {
      map['is_setup_complete'] = Variable<int>(isSetupComplete.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('studentId: $studentId, ')
          ..write('department: $department, ')
          ..write('level: $level, ')
          ..write('section: $section, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSetupComplete: $isSetupComplete, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceHistoryTableTable extends AttendanceHistoryTable
    with TableInfo<$AttendanceHistoryTableTable, AttendanceHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _courseNameMeta =
      const VerificationMeta('courseName');
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
      'course_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('present'));
  static const VerificationMeta _serverResponseMeta =
      const VerificationMeta('serverResponse');
  @override
  late final GeneratedColumn<String> serverResponse = GeneratedColumn<String>(
      'server_response', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attendanceIdMeta =
      const VerificationMeta('attendanceId');
  @override
  late final GeneratedColumn<String> attendanceId = GeneratedColumn<String>(
      'attendance_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        courseName,
        date,
        time,
        status,
        serverResponse,
        isSynced,
        attendanceId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AttendanceHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    }
    if (data.containsKey('course_name')) {
      context.handle(
          _courseNameMeta,
          courseName.isAcceptableOrUnknown(
              data['course_name']!, _courseNameMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('server_response')) {
      context.handle(
          _serverResponseMeta,
          serverResponse.isAcceptableOrUnknown(
              data['server_response']!, _serverResponseMeta));
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
    }
    if (data.containsKey('attendance_id')) {
      context.handle(
          _attendanceIdMeta,
          attendanceId.isAcceptableOrUnknown(
              data['attendance_id']!, _attendanceIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceHistoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceHistoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id']),
      courseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}course_name']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      serverResponse: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}server_response'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_synced'])!,
      attendanceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attendance_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $AttendanceHistoryTableTable createAlias(String alias) {
    return $AttendanceHistoryTableTable(attachedDatabase, alias);
  }
}

class AttendanceHistoryTableData extends DataClass
    implements Insertable<AttendanceHistoryTableData> {
  final String id;
  final String? sessionId;
  final String? courseName;
  final DateTime? date;
  final String? time;
  final String status;
  final String serverResponse;
  final int isSynced;
  final String? attendanceId;
  final DateTime? createdAt;
  const AttendanceHistoryTableData(
      {required this.id,
      this.sessionId,
      this.courseName,
      this.date,
      this.time,
      required this.status,
      required this.serverResponse,
      required this.isSynced,
      this.attendanceId,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    if (!nullToAbsent || courseName != null) {
      map['course_name'] = Variable<String>(courseName);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    map['status'] = Variable<String>(status);
    map['server_response'] = Variable<String>(serverResponse);
    map['is_synced'] = Variable<int>(isSynced);
    if (!nullToAbsent || attendanceId != null) {
      map['attendance_id'] = Variable<String>(attendanceId);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  AttendanceHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return AttendanceHistoryTableCompanion(
      id: Value(id),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      courseName: courseName == null && nullToAbsent
          ? const Value.absent()
          : Value(courseName),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      status: Value(status),
      serverResponse: Value(serverResponse),
      isSynced: Value(isSynced),
      attendanceId: attendanceId == null && nullToAbsent
          ? const Value.absent()
          : Value(attendanceId),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory AttendanceHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      courseName: serializer.fromJson<String?>(json['courseName']),
      date: serializer.fromJson<DateTime?>(json['date']),
      time: serializer.fromJson<String?>(json['time']),
      status: serializer.fromJson<String>(json['status']),
      serverResponse: serializer.fromJson<String>(json['serverResponse']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      attendanceId: serializer.fromJson<String?>(json['attendanceId']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String?>(sessionId),
      'courseName': serializer.toJson<String?>(courseName),
      'date': serializer.toJson<DateTime?>(date),
      'time': serializer.toJson<String?>(time),
      'status': serializer.toJson<String>(status),
      'serverResponse': serializer.toJson<String>(serverResponse),
      'isSynced': serializer.toJson<int>(isSynced),
      'attendanceId': serializer.toJson<String?>(attendanceId),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  AttendanceHistoryTableData copyWith(
          {String? id,
          Value<String?> sessionId = const Value.absent(),
          Value<String?> courseName = const Value.absent(),
          Value<DateTime?> date = const Value.absent(),
          Value<String?> time = const Value.absent(),
          String? status,
          String? serverResponse,
          int? isSynced,
          Value<String?> attendanceId = const Value.absent(),
          Value<DateTime?> createdAt = const Value.absent()}) =>
      AttendanceHistoryTableData(
        id: id ?? this.id,
        sessionId: sessionId.present ? sessionId.value : this.sessionId,
        courseName: courseName.present ? courseName.value : this.courseName,
        date: date.present ? date.value : this.date,
        time: time.present ? time.value : this.time,
        status: status ?? this.status,
        serverResponse: serverResponse ?? this.serverResponse,
        isSynced: isSynced ?? this.isSynced,
        attendanceId:
            attendanceId.present ? attendanceId.value : this.attendanceId,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  AttendanceHistoryTableData copyWithCompanion(
      AttendanceHistoryTableCompanion data) {
    return AttendanceHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      courseName:
          data.courseName.present ? data.courseName.value : this.courseName,
      date: data.date.present ? data.date.value : this.date,
      time: data.time.present ? data.time.value : this.time,
      status: data.status.present ? data.status.value : this.status,
      serverResponse: data.serverResponse.present
          ? data.serverResponse.value
          : this.serverResponse,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      attendanceId: data.attendanceId.present
          ? data.attendanceId.value
          : this.attendanceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceHistoryTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('courseName: $courseName, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('status: $status, ')
          ..write('serverResponse: $serverResponse, ')
          ..write('isSynced: $isSynced, ')
          ..write('attendanceId: $attendanceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, courseName, date, time, status,
      serverResponse, isSynced, attendanceId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceHistoryTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.courseName == this.courseName &&
          other.date == this.date &&
          other.time == this.time &&
          other.status == this.status &&
          other.serverResponse == this.serverResponse &&
          other.isSynced == this.isSynced &&
          other.attendanceId == this.attendanceId &&
          other.createdAt == this.createdAt);
}

class AttendanceHistoryTableCompanion
    extends UpdateCompanion<AttendanceHistoryTableData> {
  final Value<String> id;
  final Value<String?> sessionId;
  final Value<String?> courseName;
  final Value<DateTime?> date;
  final Value<String?> time;
  final Value<String> status;
  final Value<String> serverResponse;
  final Value<int> isSynced;
  final Value<String?> attendanceId;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const AttendanceHistoryTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.courseName = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.status = const Value.absent(),
    this.serverResponse = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.attendanceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceHistoryTableCompanion.insert({
    required String id,
    this.sessionId = const Value.absent(),
    this.courseName = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.status = const Value.absent(),
    this.serverResponse = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.attendanceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AttendanceHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? courseName,
    Expression<DateTime>? date,
    Expression<String>? time,
    Expression<String>? status,
    Expression<String>? serverResponse,
    Expression<int>? isSynced,
    Expression<String>? attendanceId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (courseName != null) 'course_name': courseName,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (status != null) 'status': status,
      if (serverResponse != null) 'server_response': serverResponse,
      if (isSynced != null) 'is_synced': isSynced,
      if (attendanceId != null) 'attendance_id': attendanceId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceHistoryTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? sessionId,
      Value<String?>? courseName,
      Value<DateTime?>? date,
      Value<String?>? time,
      Value<String>? status,
      Value<String>? serverResponse,
      Value<int>? isSynced,
      Value<String?>? attendanceId,
      Value<DateTime?>? createdAt,
      Value<int>? rowid}) {
    return AttendanceHistoryTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      courseName: courseName ?? this.courseName,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      serverResponse: serverResponse ?? this.serverResponse,
      isSynced: isSynced ?? this.isSynced,
      attendanceId: attendanceId ?? this.attendanceId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (serverResponse.present) {
      map['server_response'] = Variable<String>(serverResponse.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (attendanceId.present) {
      map['attendance_id'] = Variable<String>(attendanceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('courseName: $courseName, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('status: $status, ')
          ..write('serverResponse: $serverResponse, ')
          ..write('isSynced: $isSynced, ')
          ..write('attendanceId: $attendanceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('string'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [key, value, type, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  final String key;
  final String value;
  final String type;
  final DateTime? updatedAt;
  const SettingsTableData(
      {required this.key,
      required this.value,
      required this.type,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      type: Value(type),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      type: serializer.fromJson<String>(json['type']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'type': serializer.toJson<String>(type),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  SettingsTableData copyWith(
          {String? key,
          String? value,
          String? type,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      SettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
        type: type ?? this.type,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      type: data.type.present ? data.type.value : this.type,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, type, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.type == this.type &&
          other.updatedAt == this.updatedAt);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> type;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    required String value,
    this.type = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? type,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<String>? type,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return SettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConnectionLogsTableTable extends ConnectionLogsTable
    with TableInfo<$ConnectionLogsTableTable, ConnectionLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConnectionLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ipMeta = const VerificationMeta('ip');
  @override
  late final GeneratedColumn<String> ip = GeneratedColumn<String>(
      'ip', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  @override
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
      'port', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ip, port, status, errorMessage, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'connection_logs_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConnectionLogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ip')) {
      context.handle(_ipMeta, ip.isAcceptableOrUnknown(data['ip']!, _ipMeta));
    } else if (isInserting) {
      context.missing(_ipMeta);
    }
    if (data.containsKey('port')) {
      context.handle(
          _portMeta, port.isAcceptableOrUnknown(data['port']!, _portMeta));
    } else if (isInserting) {
      context.missing(_portMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConnectionLogsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConnectionLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ip: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ip'])!,
      port: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}port'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp']),
    );
  }

  @override
  $ConnectionLogsTableTable createAlias(String alias) {
    return $ConnectionLogsTableTable(attachedDatabase, alias);
  }
}

class ConnectionLogsTableData extends DataClass
    implements Insertable<ConnectionLogsTableData> {
  final String id;
  final String ip;
  final int port;
  final String status;
  final String? errorMessage;
  final DateTime? timestamp;
  const ConnectionLogsTableData(
      {required this.id,
      required this.ip,
      required this.port,
      required this.status,
      this.errorMessage,
      this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ip'] = Variable<String>(ip);
    map['port'] = Variable<int>(port);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<DateTime>(timestamp);
    }
    return map;
  }

  ConnectionLogsTableCompanion toCompanion(bool nullToAbsent) {
    return ConnectionLogsTableCompanion(
      id: Value(id),
      ip: Value(ip),
      port: Value(port),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  factory ConnectionLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConnectionLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      ip: serializer.fromJson<String>(json['ip']),
      port: serializer.fromJson<int>(json['port']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      timestamp: serializer.fromJson<DateTime?>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ip': serializer.toJson<String>(ip),
      'port': serializer.toJson<int>(port),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'timestamp': serializer.toJson<DateTime?>(timestamp),
    };
  }

  ConnectionLogsTableData copyWith(
          {String? id,
          String? ip,
          int? port,
          String? status,
          Value<String?> errorMessage = const Value.absent(),
          Value<DateTime?> timestamp = const Value.absent()}) =>
      ConnectionLogsTableData(
        id: id ?? this.id,
        ip: ip ?? this.ip,
        port: port ?? this.port,
        status: status ?? this.status,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        timestamp: timestamp.present ? timestamp.value : this.timestamp,
      );
  ConnectionLogsTableData copyWithCompanion(ConnectionLogsTableCompanion data) {
    return ConnectionLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      ip: data.ip.present ? data.ip.value : this.ip,
      port: data.port.present ? data.port.value : this.port,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionLogsTableData(')
          ..write('id: $id, ')
          ..write('ip: $ip, ')
          ..write('port: $port, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ip, port, status, errorMessage, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConnectionLogsTableData &&
          other.id == this.id &&
          other.ip == this.ip &&
          other.port == this.port &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.timestamp == this.timestamp);
}

class ConnectionLogsTableCompanion
    extends UpdateCompanion<ConnectionLogsTableData> {
  final Value<String> id;
  final Value<String> ip;
  final Value<int> port;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<DateTime?> timestamp;
  final Value<int> rowid;
  const ConnectionLogsTableCompanion({
    this.id = const Value.absent(),
    this.ip = const Value.absent(),
    this.port = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConnectionLogsTableCompanion.insert({
    required String id,
    required String ip,
    required int port,
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ip = Value(ip),
        port = Value(port);
  static Insertable<ConnectionLogsTableData> custom({
    Expression<String>? id,
    Expression<String>? ip,
    Expression<int>? port,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ip != null) 'ip': ip,
      if (port != null) 'port': port,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConnectionLogsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? ip,
      Value<int>? port,
      Value<String>? status,
      Value<String?>? errorMessage,
      Value<DateTime?>? timestamp,
      Value<int>? rowid}) {
    return ConnectionLogsTableCompanion(
      id: id ?? this.id,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ip.present) {
      map['ip'] = Variable<String>(ip.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('ip: $ip, ')
          ..write('port: $port, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentProfilesTable studentProfiles =
      $StudentProfilesTable(this);
  late final $AttendanceHistoryTableTable attendanceHistoryTable =
      $AttendanceHistoryTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $ConnectionLogsTableTable connectionLogsTable =
      $ConnectionLogsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        studentProfiles,
        attendanceHistoryTable,
        settingsTable,
        connectionLogsTable
      ];
}

typedef $$StudentProfilesTableCreateCompanionBuilder = StudentProfilesCompanion
    Function({
  required String id,
  required String name,
  required String studentId,
  required String department,
  required String level,
  required String section,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<int> isSetupComplete,
  Value<int> isSynced,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$StudentProfilesTableUpdateCompanionBuilder = StudentProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> studentId,
  Value<String> department,
  Value<String> level,
  Value<String> section,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<int> isSetupComplete,
  Value<int> isSynced,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$StudentProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSetupComplete => $composableBuilder(
      column: $table.isSetupComplete,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StudentProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSetupComplete => $composableBuilder(
      column: $table.isSetupComplete,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StudentProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<int> get isSetupComplete => $composableBuilder(
      column: $table.isSetupComplete, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentProfilesTable,
    StudentProfile,
    $$StudentProfilesTableFilterComposer,
    $$StudentProfilesTableOrderingComposer,
    $$StudentProfilesTableAnnotationComposer,
    $$StudentProfilesTableCreateCompanionBuilder,
    $$StudentProfilesTableUpdateCompanionBuilder,
    (
      StudentProfile,
      BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfile>
    ),
    StudentProfile,
    PrefetchHooks Function()> {
  $$StudentProfilesTableTableManager(
      _$AppDatabase db, $StudentProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> studentId = const Value.absent(),
            Value<String> department = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int> isSetupComplete = const Value.absent(),
            Value<int> isSynced = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentProfilesCompanion(
            id: id,
            name: name,
            studentId: studentId,
            department: department,
            level: level,
            section: section,
            phone: phone,
            photoPath: photoPath,
            isSetupComplete: isSetupComplete,
            isSynced: isSynced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String studentId,
            required String department,
            required String level,
            required String section,
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<int> isSetupComplete = const Value.absent(),
            Value<int> isSynced = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentProfilesCompanion.insert(
            id: id,
            name: name,
            studentId: studentId,
            department: department,
            level: level,
            section: section,
            phone: phone,
            photoPath: photoPath,
            isSetupComplete: isSetupComplete,
            isSynced: isSynced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StudentProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentProfilesTable,
    StudentProfile,
    $$StudentProfilesTableFilterComposer,
    $$StudentProfilesTableOrderingComposer,
    $$StudentProfilesTableAnnotationComposer,
    $$StudentProfilesTableCreateCompanionBuilder,
    $$StudentProfilesTableUpdateCompanionBuilder,
    (
      StudentProfile,
      BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfile>
    ),
    StudentProfile,
    PrefetchHooks Function()>;
typedef $$AttendanceHistoryTableTableCreateCompanionBuilder
    = AttendanceHistoryTableCompanion Function({
  required String id,
  Value<String?> sessionId,
  Value<String?> courseName,
  Value<DateTime?> date,
  Value<String?> time,
  Value<String> status,
  Value<String> serverResponse,
  Value<int> isSynced,
  Value<String?> attendanceId,
  Value<DateTime?> createdAt,
  Value<int> rowid,
});
typedef $$AttendanceHistoryTableTableUpdateCompanionBuilder
    = AttendanceHistoryTableCompanion Function({
  Value<String> id,
  Value<String?> sessionId,
  Value<String?> courseName,
  Value<DateTime?> date,
  Value<String?> time,
  Value<String> status,
  Value<String> serverResponse,
  Value<int> isSynced,
  Value<String?> attendanceId,
  Value<DateTime?> createdAt,
  Value<int> rowid,
});

class $$AttendanceHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceHistoryTableTable> {
  $$AttendanceHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get courseName => $composableBuilder(
      column: $table.courseName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serverResponse => $composableBuilder(
      column: $table.serverResponse,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attendanceId => $composableBuilder(
      column: $table.attendanceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AttendanceHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceHistoryTableTable> {
  $$AttendanceHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get courseName => $composableBuilder(
      column: $table.courseName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serverResponse => $composableBuilder(
      column: $table.serverResponse,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attendanceId => $composableBuilder(
      column: $table.attendanceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AttendanceHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceHistoryTableTable> {
  $$AttendanceHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get courseName => $composableBuilder(
      column: $table.courseName, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get serverResponse => $composableBuilder(
      column: $table.serverResponse, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get attendanceId => $composableBuilder(
      column: $table.attendanceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttendanceHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttendanceHistoryTableTable,
    AttendanceHistoryTableData,
    $$AttendanceHistoryTableTableFilterComposer,
    $$AttendanceHistoryTableTableOrderingComposer,
    $$AttendanceHistoryTableTableAnnotationComposer,
    $$AttendanceHistoryTableTableCreateCompanionBuilder,
    $$AttendanceHistoryTableTableUpdateCompanionBuilder,
    (
      AttendanceHistoryTableData,
      BaseReferences<_$AppDatabase, $AttendanceHistoryTableTable,
          AttendanceHistoryTableData>
    ),
    AttendanceHistoryTableData,
    PrefetchHooks Function()> {
  $$AttendanceHistoryTableTableTableManager(
      _$AppDatabase db, $AttendanceHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceHistoryTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceHistoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> sessionId = const Value.absent(),
            Value<String?> courseName = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<String?> time = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> serverResponse = const Value.absent(),
            Value<int> isSynced = const Value.absent(),
            Value<String?> attendanceId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttendanceHistoryTableCompanion(
            id: id,
            sessionId: sessionId,
            courseName: courseName,
            date: date,
            time: time,
            status: status,
            serverResponse: serverResponse,
            isSynced: isSynced,
            attendanceId: attendanceId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> sessionId = const Value.absent(),
            Value<String?> courseName = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<String?> time = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> serverResponse = const Value.absent(),
            Value<int> isSynced = const Value.absent(),
            Value<String?> attendanceId = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AttendanceHistoryTableCompanion.insert(
            id: id,
            sessionId: sessionId,
            courseName: courseName,
            date: date,
            time: time,
            status: status,
            serverResponse: serverResponse,
            isSynced: isSynced,
            attendanceId: attendanceId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AttendanceHistoryTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AttendanceHistoryTableTable,
        AttendanceHistoryTableData,
        $$AttendanceHistoryTableTableFilterComposer,
        $$AttendanceHistoryTableTableOrderingComposer,
        $$AttendanceHistoryTableTableAnnotationComposer,
        $$AttendanceHistoryTableTableCreateCompanionBuilder,
        $$AttendanceHistoryTableTableUpdateCompanionBuilder,
        (
          AttendanceHistoryTableData,
          BaseReferences<_$AppDatabase, $AttendanceHistoryTableTable,
              AttendanceHistoryTableData>
        ),
        AttendanceHistoryTableData,
        PrefetchHooks Function()>;
typedef $$SettingsTableTableCreateCompanionBuilder = SettingsTableCompanion
    Function({
  required String key,
  required String value,
  Value<String> type,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableTableUpdateCompanionBuilder = SettingsTableCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<String> type,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()> {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion(
            key: key,
            value: value,
            type: type,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<String> type = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion.insert(
            key: key,
            value: value,
            type: type,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()>;
typedef $$ConnectionLogsTableTableCreateCompanionBuilder
    = ConnectionLogsTableCompanion Function({
  required String id,
  required String ip,
  required int port,
  Value<String> status,
  Value<String?> errorMessage,
  Value<DateTime?> timestamp,
  Value<int> rowid,
});
typedef $$ConnectionLogsTableTableUpdateCompanionBuilder
    = ConnectionLogsTableCompanion Function({
  Value<String> id,
  Value<String> ip,
  Value<int> port,
  Value<String> status,
  Value<String?> errorMessage,
  Value<DateTime?> timestamp,
  Value<int> rowid,
});

class $$ConnectionLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTableTable> {
  $$ConnectionLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ip => $composableBuilder(
      column: $table.ip, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get port => $composableBuilder(
      column: $table.port, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ConnectionLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTableTable> {
  $$ConnectionLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ip => $composableBuilder(
      column: $table.ip, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get port => $composableBuilder(
      column: $table.port, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ConnectionLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConnectionLogsTableTable> {
  $$ConnectionLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ip =>
      $composableBuilder(column: $table.ip, builder: (column) => column);

  GeneratedColumn<int> get port =>
      $composableBuilder(column: $table.port, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ConnectionLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConnectionLogsTableTable,
    ConnectionLogsTableData,
    $$ConnectionLogsTableTableFilterComposer,
    $$ConnectionLogsTableTableOrderingComposer,
    $$ConnectionLogsTableTableAnnotationComposer,
    $$ConnectionLogsTableTableCreateCompanionBuilder,
    $$ConnectionLogsTableTableUpdateCompanionBuilder,
    (
      ConnectionLogsTableData,
      BaseReferences<_$AppDatabase, $ConnectionLogsTableTable,
          ConnectionLogsTableData>
    ),
    ConnectionLogsTableData,
    PrefetchHooks Function()> {
  $$ConnectionLogsTableTableTableManager(
      _$AppDatabase db, $ConnectionLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConnectionLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConnectionLogsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConnectionLogsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ip = const Value.absent(),
            Value<int> port = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime?> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConnectionLogsTableCompanion(
            id: id,
            ip: ip,
            port: port,
            status: status,
            errorMessage: errorMessage,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ip,
            required int port,
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime?> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConnectionLogsTableCompanion.insert(
            id: id,
            ip: ip,
            port: port,
            status: status,
            errorMessage: errorMessage,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConnectionLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConnectionLogsTableTable,
    ConnectionLogsTableData,
    $$ConnectionLogsTableTableFilterComposer,
    $$ConnectionLogsTableTableOrderingComposer,
    $$ConnectionLogsTableTableAnnotationComposer,
    $$ConnectionLogsTableTableCreateCompanionBuilder,
    $$ConnectionLogsTableTableUpdateCompanionBuilder,
    (
      ConnectionLogsTableData,
      BaseReferences<_$AppDatabase, $ConnectionLogsTableTable,
          ConnectionLogsTableData>
    ),
    ConnectionLogsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$AttendanceHistoryTableTableTableManager get attendanceHistoryTable =>
      $$AttendanceHistoryTableTableTableManager(
          _db, _db.attendanceHistoryTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$ConnectionLogsTableTableTableManager get connectionLogsTable =>
      $$ConnectionLogsTableTableTableManager(_db, _db.connectionLogsTable);
}
