/// عميل HTTP للاتصال بخادم Admin
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/server_response.dart';

class HttpClient {
  final Logger _logger = Logger();
  late final Dio _dio;

  HttpClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'AttendanceStudent/1.0',
        },
      ),
    );
    
    _logger.d('HttpClient initialized');
  }

  /// إرسال بيانات الحضور للخادم
  Future<ServerResponse> postAttendance({
    required String ipAddress,
    required int port,
    required Map<String, dynamic> data,
  }) async {
    try {
      _logger.i('Sending attendance to $ipAddress:$port');

      // إنشاء الطلب HTTP
      final uri = 'http://$ipAddress:$port/api/attendance/check-in';
      
      _logger.d('Request URI: $uri');
      _logger.d('Request Data: ${jsonEncode(data)}');

      // إرسال الطلب باستخدام Dio
      final response = await _dio.post(
        uri,
        data: data,
      );
      
      _logger.i('Response Status: ${response.statusCode}');
      _logger.d('Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // تحليل الاستجابة الناجحة
        try {
          final jsonData = response.data is Map<String, dynamic> 
              ? response.data 
              : jsonDecode(response.data.toString()) as Map<String, dynamic>;
          return ServerResponse(
            success: jsonData['success'] as bool? ?? false,
            message: jsonData['message'] as String? ?? '',
            attendanceId: jsonData['attendance_id'] as String?,
            sessionId: jsonData['session_id'] as String?,
            timestamp: DateTime.now(),
            data: jsonData['data'],
          );
        } catch (e) {
          _logger.e('Error parsing success response: $e');
          return ServerResponse.successResponse(
            message: 'تم تسجيل الحضور',
            sessionId: data['session_id'],
          );
        }
      } else if (response.statusCode == 400) {
        // خطأ في البيانات
        try {
          final jsonData = response.data is Map<String, dynamic> 
              ? response.data 
              : jsonDecode(response.data.toString()) as Map<String, dynamic>;
          return ServerResponse.errorResponse(
            message: jsonData['message'] as String? ?? AppMessages.invalidData,
          );
        } catch (e) {
          return ServerResponse.errorResponse(message: AppMessages.invalidData);
        }
      } else if (response.statusCode == 409) {
        // مسجل مسبقاً
        return ServerResponse.errorResponse(
          message: AppMessages.alreadyRegistered,
        );
      } else if (response.statusCode == 410) {
        // الجلسة مغلقة
        return ServerResponse.errorResponse(
          message: AppMessages.sessionClosed,
        );
      } else {
        // خطأ آخر من الخادم
        return ServerResponse.errorResponse(
          message: AppMessages.serverError,
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException: ${e.type} - ${e.message}');
      
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return ServerResponse.errorResponse(
          message: 'انتهت مهلة الاتصال، تأكد من أن الخادم يعمل',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        return ServerResponse.errorResponse(
          message: AppMessages.noConnection,
        );
      } else {
        return ServerResponse.errorResponse(
          message: '${AppMessages.networkError}: ${e.message}',
        );
      }
    } on SocketException catch (e) {
      _logger.e('SocketException: ${e.message}');
      _logger.e('Address: ${e.address}, Port: ${e.port}');
      return ServerResponse.errorResponse(
        message: AppMessages.noConnection,
      );
    } on TimeoutException catch (e) {
      _logger.e('TimeoutException: $e');
      return ServerResponse.errorResponse(
        message: 'انتهت مهلة الاتصال، تأكد من أن الخادم يعمل',
      );
    } on FormatException catch (e) {
      _logger.e('FormatException: $e');
      return ServerResponse.errorResponse(
        message: 'استجابة غير صالحة من الخادم',
      );
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return ServerResponse.errorResponse(
        message: '${AppMessages.networkError}: $e',
      );
    }
  }

  /// التحقق من اتصال الخادم
  Future<bool> checkConnection({
    required String ipAddress,
    required int port,
  }) async {
    try {
      final uri = 'http://$ipAddress:$port/api/health';
      
      final response = await _dio.get(
        uri,
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      _logger.w('Connection check failed: $e');
      return false;
    }
  }

  /// الحصول على معلومات الجلسة من الخادم
  Future<Map<String, dynamic>?> getSessionInfo({
    required String ipAddress,
    required int port,
    required String sessionId,
  }) async {
    try {
      final uri = 'http://$ipAddress:$port/api/session/$sessionId';
      
      final response = await _dio.get(
        uri,
        options: Options(
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        final body = response.data is Map<String, dynamic> 
            ? response.data 
            : jsonDecode(response.data.toString()) as Map<String, dynamic>;
        return body;
      }

      return null;
    } catch (e) {
      _logger.w('Failed to get session info: $e');
      return null;
    }
  }
}
