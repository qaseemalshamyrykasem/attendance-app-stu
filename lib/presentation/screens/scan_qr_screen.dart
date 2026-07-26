import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/di/di_setup.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _processQRCode(String qrData) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final qrInfo = _parseQRData(qrData);
      if (!qrInfo['isValid']) throw Exception('كود غير صالح');

      final student = await ref.read(studentRepositoryProvider).getStudent();
      if (student == null) throw Exception('يرجى إعداد الملف الشخصي');

      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final result = await attendanceRepo.submitAttendance(
        ip: qrInfo['ip'],
        port: qrInfo['port'],
        sessionId: qrInfo['sessionId'],
        studentData: {
          'student_id': student.studentId,
          'name': student.name,
          'department': student.department,
          'level': student.level,
        },
      );

      if (!mounted) return;

      // الانتقال لشاشة الحالة باستخدام الاسم الجديد والمسار المطلق
      context.pushReplacementNamed(
        AppRoutes.attendanceStatusName,
        extra: {
          'status': result.isSuccess ? 'success' : 'failed',
          'message': result.message,
        },
      );
    } catch (e) {
      if (mounted) {
        AppHelpers.showSnackBar(context, message: 'خطأ: $e');
        setState(() => _isProcessing = false);
      }
    }
  }

  Map<String, dynamic> _parseQRData(String qrData) {
    try {
      final parts = qrData.split(':');
      if (parts.length >= 3) {
        return {
          'ip': parts[0],
          'port': int.parse(parts[1]),
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
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _processQRCode(barcode.rawValue!);
                  break;
                }
              }
            },
          ),
          if (_isProcessing)
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }
}
