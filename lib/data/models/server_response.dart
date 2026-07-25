/// نموذج استجابة الخادم
library;

import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_response.freezed.dart';
part 'server_response.g.dart';

@freezed
class ServerResponse with _$ServerResponse {
  const factory ServerResponse({
    @Default(false) bool success,
    @Default('') String message,
    String? attendanceId,
    String? sessionId,
    DateTime? timestamp,
    @Default(null) dynamic data,
  }) = _ServerResponse;

  factory ServerResponse.fromJson(Map<String, dynamic> json) =>
      _$ServerResponseFromJson(json);

  /// إنشاء استجابة ناجحة
  factory ServerResponse.successResponse({
    required String message,
    String? attendanceId,
    String? sessionId,
  }) =>
      ServerResponse(
        success: true,
        message: message,
        attendanceId: attendanceId,
        sessionId: sessionId,
        timestamp: DateTime.now(),
      );

  /// إنشاء استجابة فاشلة
  factory ServerResponse.errorResponse({
    required String message,
  }) =>
      ServerResponse(
        success: false,
        message: message,
        timestamp: DateTime.now(),
      );
}

/// نموذج طلب الحضور
@freezed
class AttendanceRequest with _$AttendanceRequest {
  const AttendanceRequest._();

  const factory AttendanceRequest({
    required String studentId,
    required String name,
    required String department,
    required String level,
    required String section,
    required String deviceId,
    required String timestamp,
    required String hash,
    String? sessionId,
    String? sessionToken,
  }) = _AttendanceRequest;

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRequestFromJson(json);

  /// تحويل إلى JSON للإرسال
  Map<String, dynamic> toJsonForApi() => {
        'student_id': studentId,
        'name': name,
        'department': department,
        'level': level,
        'section': section,
        'device_id': deviceId,
        'timestamp': timestamp,
        'hash': hash,
        if (sessionId != null) 'session_id': sessionId,
        if (sessionToken != null) 'session_token': sessionToken,
      };
}

/// نموذج بيانات QR Code
@freezed
class QrCodeData with _$QrCodeData {
  const QrCodeData._();

  const factory QrCodeData({
    required String ip,
    required int port,
    required String sessionId,
    String? sessionToken,
  }) = _QrCodeData;

  factory QrCodeData.fromJson(Map<String, dynamic> json) =>
      _$QrCodeDataFromJson(json);

  /// تحليل QR Code من نص
  factory QrCodeData.parse(String qrString) {
    try {
      if (qrString.trim().startsWith('{')) {
        final decoded = jsonDecode(qrString) as Map<String, dynamic>;
        final ip = decoded['ip'] ?? decoded['server_ip'] ?? decoded['host'];
        if (ip != null && ip.toString().isNotEmpty) {
          final portVal = decoded['port'];
          final port = portVal is int
              ? portVal
              : (int.tryParse(portVal?.toString() ?? '') ?? 8080);
          final sessionId = decoded['sessionId'] ??
              decoded['session_id'] ??
              decoded['token'] ??
              '';
          final sessionToken = decoded['sessionToken'] ??
              decoded['session_token'] ??
              decoded['token'] ??
              sessionId;
          return QrCodeData(
            ip: ip.toString(),
            port: port,
            sessionId: sessionId.toString(),
            sessionToken: sessionToken.toString(),
          );
        }
      }

      if (qrString.contains('attendance://')) {
        final uriPart = qrString.replaceFirst('attendance://', '');
        final parts = uriPart.split('/');
        if (parts.length >= 2) {
          final addressParts = parts[0].split(':');
          final sessId = parts.sublist(1).join('/');
          return QrCodeData(
            ip: addressParts[0],
            port: int.tryParse(addressParts[1]) ?? 8080,
            sessionId: sessId,
            sessionToken: sessId,
          );
        }
      }

      final parts = qrString.split(':');
      if (parts.length >= 3) {
        final sessId = parts.sublist(2).join(':');
        return QrCodeData(
          ip: parts[0],
          port: int.tryParse(parts[1]) ?? 8080,
          sessionId: sessId,
          sessionToken: sessId,
        );
      }

      return const QrCodeData(ip: '', port: 0, sessionId: '');
    } catch (e) {
      return const QrCodeData(ip: '', port: 0, sessionId: '');
    }
  }

  /// التحقق من صحة البيانات
  bool get isValid => ip.isNotEmpty && port > 0 && sessionId.isNotEmpty;
}
