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
      if (!qrInfo['isValid']) throw Exception('كود QR غير مدعوم أو تالف');

      final student = await ref.read(studentRepositoryProvider).getStudent();
      if (student == null) throw Exception('يرجى إعداد الملف الشخصي أولاً');

      // إرسال التحضير للمندوب
      final result = await ref.read(attendanceRepositoryProvider).submitAttendance(
        ip: qrInfo['ip'],
        port: qrInfo['port'],
        sessionId: qrInfo['sessionId'],
        sessionToken: qrInfo['token'], // التوكن الحقيقي من المندوب
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
      // 1. محاولة فك تشفير base64Url (كما يفعل المندوب)
      try {
        // فلاتر تحتاج لتعديل الـ padding يدوياً أحياناً في base64Url
        String normalized = qrData.replaceAll('-', '+').replaceAll('_', '/');
        while (normalized.length % 4 != 0) { normalized += '='; }
        
        final decoded = utf8.decode(base64Decode(normalized));
        final json = jsonDecode(decoded);
        
        if (json['token'] != null && json['ip'] != null) {
          return {
            'ip': json['ip'],
            'port': int.parse(json['port'].toString()),
            'token': json['token'],
            'sessionId': json['sessionId'] ?? json['token'].toString().split('_').first,
            'isValid': true,
          };
        }
      } catch (e) {
        debugPrint('Base64Url parse failed: $e');
      }

      // 2. محاولة الصيغة البسيطة (Fallback)
      final parts = qrData.split(':');
      if (parts.length >= 3) {
        return {
          'ip': parts[0],
          'port': int.parse(parts[1]),
          'token': parts[2],
          'sessionId': parts[2],
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
            Container(color: Colors.black54, child: const Center(child: CircularProgressIndicator(color: Colors.white))),
        ],
      ),
    );
  }
}
