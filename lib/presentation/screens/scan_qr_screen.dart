import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/di/di_setup.dart';
import '../../core/router/app_router.dart';
import '../../core/utils/helpers.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  Future<void> _processQRCode(String qrData) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final qrInfo = _parseQRData(qrData);
      if (!qrInfo['isValid']) throw Exception('كود QR غير صالح أو غير مدعوم');

      final student = await ref.read(studentRepositoryProvider).getStudent();
      if (student == null) throw Exception('يرجى إعداد الملف الشخصي أولاً');

      final result = await ref.read(attendanceRepositoryProvider).submitAttendance(
        ip: qrInfo['ip'],
        port: qrInfo['port'],
        sessionId: qrInfo['sessionId'],
        sessionToken: qrInfo['token'], // تمرير التوكن الحقيقي
        studentData: {
          'student_id': student.studentId,
          'name': student.name,
          'department': student.department,
          'level': student.level,
        },
      );

      if (!mounted) return;
      context.pushReplacementNamed(
        AppRoutes.attendanceStatusName,
        extra: {'status': result.isSuccess ? 'success' : 'failed', 'message': result.message},
      );
    } catch (e) {
      if (mounted) {
        AppHelpers.showSnackBar(context, message: e.toString().replaceAll('Exception: ', ''));
        setState(() => _isProcessing = false);
      }
    }
  }

  Map<String, dynamic> _parseQRData(String qrData) {
    try {
      // 1. تجربة فك تشفير Base64 (الصيغة الجديدة للمندوب)
      try {
        final decoded = utf8.decode(base64Decode(qrData));
        final json = jsonDecode(decoded);
        if (json['ip'] != null && json['port'] != null) {
          return {
            'ip': json['ip'],
            'port': int.parse(json['port'].toString()),
            'token': json['token'], // التوكن الحقيقي
            'sessionId': json['sessionId'] ?? json['token'],
            'isValid': true,
          };
        }
      } catch (_) {}

      // 2. الفشل في Base64، تجربة الصيغة البسيطة (Fallback)
      final parts = qrData.split(':');
      if (parts.length >= 3) {
        return {
          'ip': parts[0],
          'port': int.parse(parts[1]),
          'sessionId': parts[2],
          'token': parts[2],
          'isValid': true,
        };
      }
    } catch (_) {}
    return {'isValid': false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مسح QR Code')),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              if (barcode.rawValue != null) _processQRCode(barcode.rawValue!);
            },
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}
