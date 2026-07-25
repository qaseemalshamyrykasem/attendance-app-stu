// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return _AttendanceModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceModel {
  String get id => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get courseName => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get serverResponse => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  String? get attendanceId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceModelCopyWith<AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceModelCopyWith<$Res> {
  factory $AttendanceModelCopyWith(
          AttendanceModel value, $Res Function(AttendanceModel) then) =
      _$AttendanceModelCopyWithImpl<$Res, AttendanceModel>;
  @useResult
  $Res call(
      {String id,
      String? sessionId,
      String? courseName,
      DateTime? date,
      String? time,
      String status,
      String serverResponse,
      bool isSynced,
      String? attendanceId,
      DateTime? createdAt});
}

/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res, $Val extends AttendanceModel>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = freezed,
    Object? courseName = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? status = null,
    Object? serverResponse = null,
    Object? isSynced = null,
    Object? attendanceId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      courseName: freezed == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      serverResponse: null == serverResponse
          ? _value.serverResponse
          : serverResponse // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceId: freezed == attendanceId
          ? _value.attendanceId
          : attendanceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceModelImplCopyWith<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  factory _$$AttendanceModelImplCopyWith(_$AttendanceModelImpl value,
          $Res Function(_$AttendanceModelImpl) then) =
      __$$AttendanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? sessionId,
      String? courseName,
      DateTime? date,
      String? time,
      String status,
      String serverResponse,
      bool isSynced,
      String? attendanceId,
      DateTime? createdAt});
}

/// @nodoc
class __$$AttendanceModelImplCopyWithImpl<$Res>
    extends _$AttendanceModelCopyWithImpl<$Res, _$AttendanceModelImpl>
    implements _$$AttendanceModelImplCopyWith<$Res> {
  __$$AttendanceModelImplCopyWithImpl(
      _$AttendanceModelImpl _value, $Res Function(_$AttendanceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = freezed,
    Object? courseName = freezed,
    Object? date = freezed,
    Object? time = freezed,
    Object? status = null,
    Object? serverResponse = null,
    Object? isSynced = null,
    Object? attendanceId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AttendanceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      courseName: freezed == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      serverResponse: null == serverResponse
          ? _value.serverResponse
          : serverResponse // ignore: cast_nullable_to_non_nullable
              as String,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceId: freezed == attendanceId
          ? _value.attendanceId
          : attendanceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceModelImpl implements _AttendanceModel {
  const _$AttendanceModelImpl(
      {required this.id,
      this.sessionId,
      this.courseName,
      this.date,
      this.time,
      this.status = 'present',
      this.serverResponse = '',
      this.isSynced = false,
      this.attendanceId,
      this.createdAt});

  factory _$AttendanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? sessionId;
  @override
  final String? courseName;
  @override
  final DateTime? date;
  @override
  final String? time;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String serverResponse;
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final String? attendanceId;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AttendanceModel(id: $id, sessionId: $sessionId, courseName: $courseName, date: $date, time: $time, status: $status, serverResponse: $serverResponse, isSynced: $isSynced, attendanceId: $attendanceId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.serverResponse, serverResponse) ||
                other.serverResponse == serverResponse) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.attendanceId, attendanceId) ||
                other.attendanceId == attendanceId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, sessionId, courseName, date,
      time, status, serverResponse, isSynced, attendanceId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      __$$AttendanceModelImplCopyWithImpl<_$AttendanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceModel implements AttendanceModel {
  const factory _AttendanceModel(
      {required final String id,
      final String? sessionId,
      final String? courseName,
      final DateTime? date,
      final String? time,
      final String status,
      final String serverResponse,
      final bool isSynced,
      final String? attendanceId,
      final DateTime? createdAt}) = _$AttendanceModelImpl;

  factory _AttendanceModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get sessionId;
  @override
  String? get courseName;
  @override
  DateTime? get date;
  @override
  String? get time;
  @override
  String get status;
  @override
  String get serverResponse;
  @override
  bool get isSynced;
  @override
  String? get attendanceId;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
