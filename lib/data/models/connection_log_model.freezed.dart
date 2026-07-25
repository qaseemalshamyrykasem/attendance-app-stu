// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectionLogModel _$ConnectionLogModelFromJson(Map<String, dynamic> json) {
  return _ConnectionLogModel.fromJson(json);
}

/// @nodoc
mixin _$ConnectionLogModel {
  String get id => throw _privateConstructorUsedError;
  String get ip => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionLogModelCopyWith<ConnectionLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionLogModelCopyWith<$Res> {
  factory $ConnectionLogModelCopyWith(
          ConnectionLogModel value, $Res Function(ConnectionLogModel) then) =
      _$ConnectionLogModelCopyWithImpl<$Res, ConnectionLogModel>;
  @useResult
  $Res call(
      {String id,
      String ip,
      int port,
      String status,
      String? errorMessage,
      DateTime? timestamp});
}

/// @nodoc
class _$ConnectionLogModelCopyWithImpl<$Res, $Val extends ConnectionLogModel>
    implements $ConnectionLogModelCopyWith<$Res> {
  _$ConnectionLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ip = null,
    Object? port = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionLogModelImplCopyWith<$Res>
    implements $ConnectionLogModelCopyWith<$Res> {
  factory _$$ConnectionLogModelImplCopyWith(_$ConnectionLogModelImpl value,
          $Res Function(_$ConnectionLogModelImpl) then) =
      __$$ConnectionLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ip,
      int port,
      String status,
      String? errorMessage,
      DateTime? timestamp});
}

/// @nodoc
class __$$ConnectionLogModelImplCopyWithImpl<$Res>
    extends _$ConnectionLogModelCopyWithImpl<$Res, _$ConnectionLogModelImpl>
    implements _$$ConnectionLogModelImplCopyWith<$Res> {
  __$$ConnectionLogModelImplCopyWithImpl(_$ConnectionLogModelImpl _value,
      $Res Function(_$ConnectionLogModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ip = null,
    Object? port = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$ConnectionLogModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ip: null == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionLogModelImpl implements _ConnectionLogModel {
  const _$ConnectionLogModelImpl(
      {required this.id,
      required this.ip,
      required this.port,
      this.status = 'pending',
      this.errorMessage,
      this.timestamp});

  factory _$ConnectionLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionLogModelImplFromJson(json);

  @override
  final String id;
  @override
  final String ip;
  @override
  final int port;
  @override
  @JsonKey()
  final String status;
  @override
  final String? errorMessage;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'ConnectionLogModel(id: $id, ip: $ip, port: $port, status: $status, errorMessage: $errorMessage, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, ip, port, status, errorMessage, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionLogModelImplCopyWith<_$ConnectionLogModelImpl> get copyWith =>
      __$$ConnectionLogModelImplCopyWithImpl<_$ConnectionLogModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionLogModelImplToJson(
      this,
    );
  }
}

abstract class _ConnectionLogModel implements ConnectionLogModel {
  const factory _ConnectionLogModel(
      {required final String id,
      required final String ip,
      required final int port,
      final String status,
      final String? errorMessage,
      final DateTime? timestamp}) = _$ConnectionLogModelImpl;

  factory _ConnectionLogModel.fromJson(Map<String, dynamic> json) =
      _$ConnectionLogModelImpl.fromJson;

  @override
  String get id;
  @override
  String get ip;
  @override
  int get port;
  @override
  String get status;
  @override
  String? get errorMessage;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$ConnectionLogModelImplCopyWith<_$ConnectionLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
