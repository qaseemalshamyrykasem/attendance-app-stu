import 'package:drift/drift.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../../core/constants/app_constants.dart';
import '../../data/data_sources/local/local_database.dart';
import '../../data/models/attendance_model.dart';
import '../../services/network/http_client.dart';
import '../../../domain/repositories/attendance_repository.dart';
import '../../../domain/entities/attendance_entity.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AppDatabase _database;
  final HttpClient _httpClient;

  AttendanceRepositoryImpl({
    required AppDatabase database,
    required HttpClient httpClient,
  })  : _database = database,
        _httpClient = httpClient;

  @override
  Future<AttendanceEntity> submitAttendance({
    required String ip,
    required int port,
    required String sessionId,
    String? sessionToken,
    required Map<String, dynamic> studentData,
  }) async {
    await _logConnectionAttempt(ip, port, 'pending');

    try {
      // الحصول على Device ID (مهم جداً للمندوب)
      String deviceId = 'unknown_device';
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      }

      // إعداد البيانات المرسلة لتوافق تطبيق المندوب (حسب كلاس CheckInRequest)
      final payload = {
        'student_id': studentData['student_id'],
        'session_token': sessionToken ?? sessionId,
        'device_id': deviceId,
        'timestamp': DateTime.now().toIso8601String(),
        // حقول إضافية للمندوب (إضافية)
        'student_name': studentData['name'],
        'session_id': sessionId,
      };

      final response = await _httpClient.postAttendance(
        ipAddress: ip,
        port: port,
        data: payload,
      );

      if (response.success) {
        await _updateConnectionLog(ip: ip, port: port, status: 'success');

        final attendanceRecord = AttendanceModel(
          id: _generateId(),
          sessionId: sessionId,
          courseName: response.data?['course_name'] ?? studentData['course_name'] ?? '',
          date: DateTime.now(),
          time: _getCurrentTime(),
          status: AppConstants.statusPresent,
          serverResponse: response.message,
          isSynced: true,
          attendanceId: response.attendanceId,
          createdAt: DateTime.now(),
        );

        await _addAttendanceRecord(attendanceRecord);

        return AttendanceEntity(
          id: attendanceRecord.id,
          sessionId: sessionId,
          courseName: attendanceRecord.courseName,
          date: attendanceRecord.date!,
          time: attendanceRecord.time ?? '',
          status: AppConstants.statusPresent,
          message: response.message,
          isSuccess: true,
        );
      } else {
        await _updateConnectionLog(ip: ip, port: port, status: 'failed', error: response.message);
        return AttendanceEntity(
          id: _generateId(),
          sessionId: sessionId,
          date: DateTime.now(),
          time: _getCurrentTime(),
          status: 'failed',
          message: response.message,
          isSuccess: false,
        );
      }
    } catch (e) {
      await _updateConnectionLog(ip: ip, port: port, status: 'timeout', error: e.toString());
      return AttendanceEntity(
        id: _generateId(),
        sessionId: sessionId,
        date: DateTime.now(),
        time: _getCurrentTime(),
        status: 'failed',
        message: 'فشل الاتصال بالمندوب، تأكد من التواجد على نفس الشبكة',
        isSuccess: false,
      );
    }
  }

  // ... (بقية الدوال تبقى كما هي)

  @override
  Future<List<AttendanceEntity>> getAttendanceHistory({int? limit, int? offset}) async {
    final records = await _database.getAllAttendanceRecords(limit: limit, offset: offset);
    return records.map((record) => AttendanceEntity(
      id: record.id,
      sessionId: record.sessionId,
      courseName: record.courseName,
      date: record.date ?? DateTime.now(),
      time: record.time ?? '',
      status: record.status,
      message: record.serverResponse,
      isSuccess: record.isSynced == 1 && record.status != 'failed',
    )).toList();
  }

  @override
  Future<List<AttendanceEntity>> searchAttendanceRecords({String? dateQuery, String? statusFilter}) async {
    final records = await _database.searchAttendanceRecords(statusFilter: statusFilter);
    return records.map((record) => AttendanceEntity(
      id: record.id,
      sessionId: record.sessionId,
      courseName: record.courseName,
      date: record.date ?? DateTime.now(),
      time: record.time ?? '',
      status: record.status,
      message: record.serverResponse,
      isSuccess: record.isSynced == 1 && record.status != 'failed',
    )).toList();
  }

  @override
  Future<List<AttendanceEntity>> searchRecords({String? statusFilter}) async {
    return searchAttendanceRecords(statusFilter: statusFilter);
  }

  @override
  Future<int> getAttendanceCount() async => await _database.getAttendanceCount();

  @override
  Future<void> clearHistory() async => await _database.clearAttendanceHistory();

  Future<void> _addAttendanceRecord(AttendanceModel record) async {
    await _database.addAttendanceRecord(AttendanceHistoryTableCompanion(
      id: Value(record.id),
      sessionId: Value(record.sessionId),
      courseName: Value(record.courseName),
      date: Value(record.date),
      time: Value(record.time),
      status: Value(record.status),
      serverResponse: Value(record.serverResponse),
      isSynced: Value(record.isSynced ? 1 : 0),
      attendanceId: Value(record.attendanceId),
      createdAt: Value(record.createdAt),
    ));
  }

  Future<void> _logConnectionAttempt(String ip, int port, String status) async {
    await _database.addConnectionLog(ConnectionLogsTableCompanion(
      id: Value(_generateId()),
      ip: Value(ip),
      port: Value(port),
      status: Value(status),
      timestamp: Value(DateTime.now()),
    ));
  }

  Future<void> _updateConnectionLog({required String ip, required int port, required String status, String? error}) async {
    await _database.addConnectionLog(ConnectionLogsTableCompanion(
      id: Value(_generateId()),
      ip: Value(ip),
      port: Value(port),
      status: Value(status),
      errorMessage: Value(error),
      timestamp: Value(DateTime.now()),
    ));
  }

  String _generateId() => '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
