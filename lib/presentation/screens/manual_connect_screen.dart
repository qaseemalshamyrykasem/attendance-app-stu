import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final _tokenController = TextEditingController(); // حقل التوكن أو معرف الجلسة
  bool _isLoading = false;

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final student = await ref.read(studentRepositoryProvider).getStudent();
      if (student == null) throw Exception('يرجى إعداد الملف الشخصي أولاً');

      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      
      // في الاتصال اليدوي، نستخدم التوكن المدخل أو نستخدم الـ IP كمعرف مؤقت
      final token = _tokenController.text.trim();
      
      final result = await attendanceRepo.submitAttendance(
        ip: _ipController.text.trim(),
        port: int.parse(_portController.text.trim()),
        sessionId: token.isEmpty ? 'manual_session' : token,
        sessionToken: token.isEmpty ? null : token, // نرسله null ليقوم الـ Repository بالمحاولة الأنسب
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
        extra: {
          'status': result.isSuccess ? 'success' : 'failed',
          'message': result.message,
        },
      );
    } catch (e) {
      if (mounted) {
        AppHelpers.showSnackBar(context, message: 'خطأ: $e');
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اتصال يدوي بالمندوب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('أدخل بيانات الشبكة الخاصة بجهاز المندوب:', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(labelText: 'عنوان IP (مثلاً 192.168.1.5)', prefixIcon: Icon(Icons.lan)),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _portController,
                decoration: const InputDecoration(labelText: 'المنفذ (Port)', prefixIcon: Icon(Icons.numbers)),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  labelText: 'معرف الجلسة / التوكن (اختياري)',
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'اتركه فارغاً إذا لم يزودك المندوب به',
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _connect,
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : const Text('تسجيل الحضور الآن', style: TextStyle(fontSize: 16, fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
