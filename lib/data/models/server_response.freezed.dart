// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) {
  return _ServerResponse.fromJson(json);
}

/// @nodoc
mixin _$ServerResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get attendanceId => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServerResponseCopyWith<ServerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerResponseCopyWith<$Res> {
  factory $ServerResponseCopyWith(
          ServerResponse value, $Res Function(ServerResponse) then) =
      _$ServerResponseCopyWithImpl<$Res, ServerResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      String? attendanceId,
      String? sessionId,
      DateTime? timestamp,
      dynamic data});
}

/// @nodoc
class _$ServerResponseCopyWithImpl<$Res, $Val extends ServerResponse>
    implements $ServerResponseCopyWith<$Res> {
  _$ServerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? attendanceId = freezed,
    Object? sessionId = freezed,
    Object? timestamp = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceId: freezed == attendanceId
          ? _value.attendanceId
          : attendanceId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerResponseImplCopyWith<$Res>
    implements $ServerResponseCopyWith<$Res> {
  factory _$$ServerResponseImplCopyWith(_$ServerResponseImpl value,
          $Res Function(_$ServerResponseImpl) then) =
      __$$ServerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      String? attendanceId,
      String? sessionId,
      DateTime? timestamp,
      dynamic data});
}

/// @nodoc
class __$$ServerResponseImplCopyWithImpl<$Res>
    extends _$ServerResponseCopyWithImpl<$Res, _$ServerResponseImpl>
    implements _$$ServerResponseImplCopyWith<$Res> {
  __$$ServerResponseImplCopyWithImpl(
      _$ServerResponseImpl _value, $Res Function(_$ServerResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? attendanceId = freezed,
    Object? sessionId = freezed,
    Object? timestamp = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ServerResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceId: freezed == attendanceId
          ? _value.attendanceId
          : attendanceId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerResponseImpl implements _ServerResponse {
  const _$ServerResponseImpl(
      {this.success = false,
      this.message = '',
      this.attendanceId,
      this.sessionId,
      this.timestamp,
      this.data = null});

  factory _$ServerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  final String? attendanceId;
  @override
  final String? sessionId;
  @override
  final DateTime? timestamp;
  @override
  @JsonKey()
  final dynamic data;

  @override
  String toString() {
    return 'ServerResponse(success: $success, message: $message, attendanceId: $attendanceId, sessionId: $sessionId, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.attendanceId, attendanceId) ||
                other.attendanceId == attendanceId) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, attendanceId,
      sessionId, timestamp, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerResponseImplCopyWith<_$ServerResponseImpl> get copyWith =>
      __$$ServerResponseImplCopyWithImpl<_$ServerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerResponseImplToJson(
      this,
    );
  }
}

abstract class _ServerResponse implements ServerResponse {
  const factory _ServerResponse(
      {final bool success,
      final String message,
      final String? attendanceId,
      final String? sessionId,
      final DateTime? timestamp,
      final dynamic data}) = _$ServerResponseImpl;

  factory _ServerResponse.fromJson(Map<String, dynamic> json) =
      _$ServerResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String? get attendanceId;
  @override
  String? get sessionId;
  @override
  DateTime? get timestamp;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$ServerResponseImplCopyWith<_$ServerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceRequest _$AttendanceRequestFromJson(Map<String, dynamic> json) {
  return _AttendanceRequest.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRequest {
  String get studentId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get sessionToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceRequestCopyWith<AttendanceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRequestCopyWith<$Res> {
  factory $AttendanceRequestCopyWith(
          AttendanceRequest value, $Res Function(AttendanceRequest) then) =
      _$AttendanceRequestCopyWithImpl<$Res, AttendanceRequest>;
  @useResult
  $Res call(
      {String studentId,
      String name,
      String department,
      String level,
      String section,
      String deviceId,
      String timestamp,
      String hash,
      String? sessionId,
      String? sessionToken});
}

/// @nodoc
class _$AttendanceRequestCopyWithImpl<$Res, $Val extends AttendanceRequest>
    implements $AttendanceRequestCopyWith<$Res> {
  _$AttendanceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? name = null,
    Object? department = null,
    Object? level = null,
    Object? section = null,
    Object? deviceId = null,
    Object? timestamp = null,
    Object? hash = null,
    Object? sessionId = freezed,
    Object? sessionToken = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceRequestImplCopyWith<$Res>
    implements $AttendanceRequestCopyWith<$Res> {
  factory _$$AttendanceRequestImplCopyWith(_$AttendanceRequestImpl value,
          $Res Function(_$AttendanceRequestImpl) then) =
      __$$AttendanceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      String name,
      String department,
      String level,
      String section,
      String deviceId,
      String timestamp,
      String hash,
      String? sessionId,
      String? sessionToken});
}

/// @nodoc
class __$$AttendanceRequestImplCopyWithImpl<$Res>
    extends _$AttendanceRequestCopyWithImpl<$Res, _$AttendanceRequestImpl>
    implements _$$AttendanceRequestImplCopyWith<$Res> {
  __$$AttendanceRequestImplCopyWithImpl(_$AttendanceRequestImpl _value,
      $Res Function(_$AttendanceRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? name = null,
    Object? department = null,
    Object? level = null,
    Object? section = null,
    Object? deviceId = null,
    Object? timestamp = null,
    Object? hash = null,
    Object? sessionId = freezed,
    Object? sessionToken = freezed,
  }) {
    return _then(_$AttendanceRequestImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRequestImpl extends _AttendanceRequest {
  const _$AttendanceRequestImpl(
      {required this.studentId,
      required this.name,
      required this.department,
      required this.level,
      required this.section,
      required this.deviceId,
      required this.timestamp,
      required this.hash,
      this.sessionId,
      this.sessionToken})
      : super._();

  factory _$AttendanceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRequestImplFromJson(json);

  @override
  final String studentId;
  @override
  final String name;
  @override
  final String department;
  @override
  final String level;
  @override
  final String section;
  @override
  final String deviceId;
  @override
  final String timestamp;
  @override
  final String hash;
  @override
  final String? sessionId;
  @override
  final String? sessionToken;

  @override
  String toString() {
    return 'AttendanceRequest(studentId: $studentId, name: $name, department: $department, level: $level, section: $section, deviceId: $deviceId, timestamp: $timestamp, hash: $hash, sessionId: $sessionId, sessionToken: $sessionToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRequestImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, studentId, name, department,
      level, section, deviceId, timestamp, hash, sessionId, sessionToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRequestImplCopyWith<_$AttendanceRequestImpl> get copyWith =>
      __$$AttendanceRequestImplCopyWithImpl<_$AttendanceRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRequestImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRequest extends AttendanceRequest {
  const factory _AttendanceRequest(
      {required final String studentId,
      required final String name,
      required final String department,
      required final String level,
      required final String section,
      required final String deviceId,
      required final String timestamp,
      required final String hash,
      final String? sessionId,
      final String? sessionToken}) = _$AttendanceRequestImpl;
  const _AttendanceRequest._() : super._();

  factory _AttendanceRequest.fromJson(Map<String, dynamic> json) =
      _$AttendanceRequestImpl.fromJson;

  @override
  String get studentId;
  @override
  String get name;
  @override
  String get department;
  @override
  String get level;
  @override
  String get section;
  @override
  String get deviceId;
  @override
  String get timestamp;
  @override
  String get hash;
  @override
  String? get sessionId;
  @override
  String? get sessionToken;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceRequestImplCopyWith<_$AttendanceRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrCodeData _$QrCodeDataFromJson(Map<String, dynamic> json) {
  return _QrCodeData.fromJson(json);
}

/// @nodoc
mixin _$QrCodeData {
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String? get sessionToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QrCodeDataCopyWith<QrCodeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCodeDataCopyWith<$Res> {
  factory $QrCodeDataCopyWith(
          QrCodeData value, $Res Function(QrCodeData) then) =
      _$QrCodeDataCopyWithImpl<$Res, QrCodeData>;
  @useResult
  $Res call({String ip, int port, String sessionId, String? sessionToken});
}

/// @nodoc
class _$QrCodeDataCopyWithImpl<$Res, $Val extends QrCodeData>
    implements $QrCodeDataCopyWith<$Res> {
  _$QrCodeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
    Object? sessionId = null,
    Object? sessionToken = freezed,
  }) {
    return _then(_value.copyWith(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrCodeDataImplCopyWith<$Res>
    implements $QrCodeDataCopyWith<$Res> {
  factory _$$QrCodeDataImplCopyWith(
          _$QrCodeDataImpl value, $Res Function(_$QrCodeDataImpl) then) =
      __$$QrCodeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ip, int port, String sessionId, String? sessionToken});
}

/// @nodoc
class __$$QrCodeDataImplCopyWithImpl<$Res>
    extends _$QrCodeDataCopyWithImpl<$Res, _$QrCodeDataImpl>
    implements _$$QrCodeDataImplCopyWith<$Res> {
  __$$QrCodeDataImplCopyWithImpl(
      _$QrCodeDataImpl _value, $Res Function(_$QrCodeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = null,
    Object? port = null,
    Object? sessionId = null,
    Object? sessionToken = freezed,
  }) {
    return _then(_$QrCodeDataImpl(
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionToken: freezed == sessionToken
          ? _value.sessionToken
          : sessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QrCodeDataImpl extends _QrCodeData {
  const _$QrCodeDataImpl(
      {required this.ip,
      required this.port,
      required this.sessionId,
      this.sessionToken})
      : super._();

  factory _$QrCodeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrCodeDataImplFromJson(json);

  @override
  final String ip;
  @override
  final int port;
  @override
  final String sessionId;
  @override
  final String? sessionToken;

  @override
  String toString() {
    return 'QrCodeData(ip: $ip, port: $port, sessionId: $sessionId, sessionToken: $sessionToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrCodeDataImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ip, port, sessionId, sessionToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QrCodeDataImplCopyWith<_$QrCodeDataImpl> get copyWith =>
      __$$QrCodeDataImplCopyWithImpl<_$QrCodeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrCodeDataImplToJson(
      this,
    );
  }
}

abstract class _QrCodeData extends QrCodeData {
  const factory _QrCodeData(
      {required final String ip,
      required final int port,
      required final String sessionId,
      final String? sessionToken}) = _$QrCodeDataImpl;
  const _QrCodeData._() : super._();

  factory _QrCodeData.fromJson(Map<String, dynamic> json) =
      _$QrCodeDataImpl.fromJson;

  @override
  String get ip;
  @override
  int get port;
  @override
  String get sessionId;
  @override
  String? get sessionToken;
  @override
  @JsonKey(ignore: true)
  _$$QrCodeDataImplCopyWith<_$QrCodeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
