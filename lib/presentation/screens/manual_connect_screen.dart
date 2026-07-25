/// شاشة الاتصال اليدوي
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/di_setup.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';

class ManualConnectScreen extends ConsumerStatefulWidget {
  const ManualConnectScreen({super.key});

  @override
  ConsumerState<ManualConnectScreen> createState() => _ManualConnectScreenState();
}

class _ManualConnectScreenState extends ConsumerState<ManualConnectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  final _sessionIdController = TextEditingController();

  bool _isLoading = false;
  bool _isAutoFillLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadSavedConnectionInfo();
  }

  Future<void> _loadSavedConnectionInfo() async {
    if (_isAutoFillLoaded) return;
    
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      final ip = await settingsRepo.getLastIpAddress();
      final port = await settingsRepo.getLastPort();

      if (mounted && (ip != null || port != null)) {
        setState(() {
          if (ip != null) _ipController.text = ip;
          if (port != null) _portController.text = port.toString();
          if (_portController.text.isEmpty) {
            _portController.text = AppConstants.defaultPort.toString();
          }
          _isAutoFillLoaded = true;
        });
      } else if (mounted) {
        setState(() {
          _portController.text = AppConstants.defaultPort.toString();
          _isAutoFillLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading connection info: $e');
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _sessionIdController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) return;

    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? AppConstants.defaultPort;
    final sessionId = _sessionIdController.text.trim();

    // التحقق من صحة IP
    if (!AppHelpers.isValidIp(ip)) {
      AppHelpers.showSnackBar(
        context,
        message: AppMessages.invalidIpFormat,
        icon: Icons.error_outline,
        backgroundColor: AppColors.error,
      );
      return;
    }

    // حفظ معلومات الاتصال
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.saveConnectionInfo(ip: ip, port: port);
    } catch (e) {
      debugPrint('Error saving connection info: $e');
    }

    setState(() => _isLoading = true);

    try {
      // الحصول على بيانات الطالب
      final studentRepo = ref.read(studentRepositoryProvider);
      final student = await studentRepo.getStudent();

      if (student == null) {
        throw Exception('لم يتم العثور على بيانات الطالب');
      }

      // الانتقال لشاشة الحالة
      context.push(
        '/home/${AppRoutes.attendanceStatusName}',
        extra: {'status': 'pending', 'message': 'جاري الاتصال...'},
      );

      // إرسال بيانات الحضور
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final result = await attendanceRepo.submitAttendance(
        ip: ip,
        port: port,
        sessionId: sessionId,
        sessionToken: sessionId,
        studentData: {
          'student_id': student.studentId,
          'name': student.name,
          'department': student.department,
          'level': student.level,
          'section': student.section,
        },
      );

      if (!mounted) return;

      context.pop(); // إغلاق التحميل

      context.push(
        '/home/${AppRoutes.attendanceStatusName}',
        extra: {
          'status': result.isSuccess ? 'success' : result.status,
          'message': result.message,
        },
      );

      // إشعار
      final notificationService = ref.read(notificationServiceProvider);
      if (result.isSuccess) {
        notificationService.showAttendanceSuccess(result.message);
      } else {
        notificationService.showAttendanceError(result.message);
      }

    } catch (e) {
      if (!mounted) return;

      context.pop(); // إغلاق التحميل

      AppHelpers.showSnackBar(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
        icon: Icons.error_outline,
        backgroundColor: AppColors.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.connectTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // أيقونة الاتصال
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 25.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.wifi_tethering_rounded,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'أدخل بيانات الاتصال بالمندوب',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'يمكنك الحصول على هذه البيانات من المندوب',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // حقل IP Address
              TextFormField(
                controller: _ipController,
                keyboardType: TextInputType.text,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'عنوان IP *',
                  prefixIcon: Icon(Icons.language_outlined),
                  hintText: '192.168.1.100',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppMessages.ipRequired;
                  }
                  if (!AppHelpers.isValidIp(value.trim())) {
                    return AppMessages.invalidIpFormat;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // حقل Port
              TextFormField(
                controller: _portController,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'رقم المنفذ (Port) *',
                  prefixIcon: const Icon(Icons.settings_input_antenna_outlined),
                  hintText: AppConstants.defaultPort.toString(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppMessages.portRequired;
                  }
                  if (!AppHelpers.isValidPort(value.trim())) {
                    return AppMessages.invalidPortFormat;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // حقل Session ID (اختياري)
              TextFormField(
                controller: _sessionIdController,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'معرف الجلسة (اختياري)',
                  prefixIcon: Icon(Icons.fingerprint_outlined),
                  hintText: 'يتم ملؤه تلقائياً من QR Code',
                ),
              ),

              const SizedBox(height: 32),

              // زر الاتصال
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _connect,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_rounded),
                  label: Text(
                    _isLoading ? 'جاري الاتصال...' : 'تسجيل الحضور',
                    style: const TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // رابط لمسح QR
              Center(
                child: TextButton.icon(
                  onPressed: () => context.push('/home/${AppRoutes.scan}'),
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text(
                    'أو امسح QR Code بدلاً من ذلك',
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
