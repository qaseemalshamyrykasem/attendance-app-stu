/// شاشة مسح QR Code
library;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/constants/app_constants.dart';
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
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  
  bool _isScanning = true;
  bool _isProcessing = false;
  String? _lastScannedCode;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (!_isScanning || _isProcessing) return;

    final barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final rawValue = barcode.rawValue;
      if (rawValue == null || rawValue.isEmpty) continue;
      
      // تجنب تكرار المسح
      if (_lastScannedCode == rawValue) continue;
      
      setState(() {
        _lastScannedCode = rawValue;
        _isProcessing = true;
        _isScanning = false;
      });

      // إيقاف الكاميرا مؤقتاً
      await _controller.stop();

      // معالجة QR Code
      await _processQRCode(rawValue);
      
      // استئناف المسح بعد ثوانٍ
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isScanning = true;
            _isProcessing = false;
            _lastScannedCode = null;
          });
          _controller.start();
        }
      });
      
      break; // معالجة كود واحد فقط
    }
  }

  Future<void> _processQRCode(String qrData) async {
    try {
      // تحليل بيانات QR
      final qrInfo = _parseQRData(qrData);
      
      if (!qrInfo['isValid']) {
        AppHelpers.showSnackBar(
          context,
          message: 'QR Code غير صالح',
          icon: Icons.error_outline,
          backgroundColor: AppColors.error,
        );
        return;
      }

      // الحصول على بيانات الطالب
      final studentRepo = ref.read(studentRepositoryProvider);
      final student = await studentRepo.getStudent();
      
      if (student == null) {
        AppHelpers.showSnackBar(
          context,
          message: 'لم يتم العثور على بيانات الطالب',
          icon: Icons.error_outline,
          backgroundColor: AppColors.error,
        );
        return;
      }

      // الانتقال لشاشة الحالة أثناء المعالجة
      context.push(
        '/home/${AppRoutes.attendanceStatusName}',
        extra: {'status': 'pending', 'message': 'جاري تسجيل الحضور...'},
      );

      // إرسال بيانات الحضور
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final result = await attendanceRepo.submitAttendance(
        ip: qrInfo['ip'] as String,
        port: qrInfo['port'] as int,
        sessionId: qrInfo['sessionId'] as String,
        sessionToken: qrInfo['sessionToken'] as String?,
        studentData: {
          'student_id': student.studentId,
          'name': student.name,
          'department': student.department,
          'level': student.level,
          'section': student.section,
        },
      );

      if (!mounted) return;

      // تحديث شاشة الحالة بالنتيجة
      context.pop(); // إغلاق شاشة التحميل
      
      context.push(
        '/home/${AppRoutes.attendanceStatusName}',
        extra: {
          'status': result.isSuccess ? 'success' : result.status,
          'message': result.message,
        },
      );

      // عرض إشعار
      final notificationService = ref.read(notificationServiceProvider);
      if (result.isSuccess) {
        notificationService.showAttendanceSuccess(result.message);
      } else {
        notificationService.showAttendanceError(result.message);
      }

    } catch (e) {
      if (!mounted) return;
      
      AppHelpers.showSnackBar(
        context,
        message: 'خطأ في معالجة QR: $e',
        icon: Icons.error_outline,
        backgroundColor: AppColors.error,
      );
    }
  }

  Map<String, dynamic> _parseQRData(String qrData) {
    // التنسيقات المدعومة:
    // 1. JSON format {"ip":"...", "port":8080, "sessionId":"...", "sessionToken":"..."}
    // 2. attendance://IP:PORT/SESSION_ID
    // 3. IP:PORT:SESSION_ID
    
    try {
      // 1. تجربة تنسيق JSON
      try {
        final decoded = jsonDecode(qrData) as Map<String, dynamic>;
        final ip = decoded['ip'] ?? decoded['server_ip'] ?? decoded['host'];
        if (ip != null && ip.toString().isNotEmpty) {
          final portVal = decoded['port'];
          final port = portVal is int ? portVal : (int.tryParse(portVal?.toString() ?? '') ?? AppConstants.defaultPort);
          final sessionId = decoded['sessionId'] ?? decoded['session_id'] ?? '';
          final sessionToken = decoded['sessionToken'] ?? decoded['session_token'] ?? decoded['token'] ?? sessionId;
          return {
            'ip': ip.toString(),
            'port': port,
            'sessionId': sessionId.toString(),
            'sessionToken': sessionToken.toString(),
            'isValid': true,
          };
        }
      } catch (_) {}

      // 2. تنسيق URI
      if (qrData.contains('attendance://')) {
        final uriPart = qrData.replaceFirst('attendance://', '');
        final parts = uriPart.split('/');
        if (parts.length >= 2) {
          final addressParts = parts[0].split(':');
          final sessId = parts.sublist(1).join('/');
          return {
            'ip': addressParts[0],
            'port': int.tryParse(addressParts[1]) ?? AppConstants.defaultPort,
            'sessionId': sessId,
            'sessionToken': sessId,
            'isValid': true,
          };
        }
      }

      // 3. تنسيق بسيط
      final parts = qrData.split(':');
      if (parts.length >= 3) {
        final sessId = parts.sublist(2).join(':');
        return {
          'ip': parts[0],
          'port': int.tryParse(parts[1]) ?? AppConstants.defaultPort,
          'sessionId': sessId,
          'sessionToken': sessId,
          'isValid': true,
        };
      }

      return {'isValid': false};
    } catch (e) {
      return {'isValid': false};
    }
  }

  void _toggleFlashlight() {
    _controller.toggleTorch();
  }

  void _switchCamera() {
    _controller.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.scanTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleFlashlight,
            icon: const Icon(Icons.flash_on_outlined),
          ),
          IconButton(
            onPressed: _switchCamera,
            icon: const Icon(Icons.cameraswitch_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          // كاميرا المسح
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // طبقة التغطية
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // منطقة المسح
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // إطار المسح
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isProcessing 
                          ? AppColors.warning 
                          : Colors.white.withOpacity(0.8),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: _isProcessing
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'جاري المعالجة...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 32),

                // التعليمات
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'وجّه الكاميرا نحو QR Code لتسجيل الحضور',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // زر الإلغاء
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            child: SafeArea(
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
