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
  final _sessionIdController = TextEditingController();
  bool _isLoading = false;

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final student = await ref.read(studentRepositoryProvider).getStudent();
      if (student == null) throw Exception('يرجى إعداد الملف الشخصي أولاً');

      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final result = await attendanceRepo.submitAttendance(
        ip: _ipController.text.trim(),
        port: int.parse(_portController.text.trim()),
        sessionId: _sessionIdController.text.trim().isEmpty ? 'manual' : _sessionIdController.text.trim(),
        studentData: {
          'student_id': student.studentId,
          'name': student.name,
          'department': student.department,
          'level': student.level,
        },
      );

      if (!mounted) return;
      
      // الانتقال لشاشة الحالة (مرة واحدة فقط بالنتيجة النهائية)
      context.pushReplacementNamed(
        AppRoutes.attendanceStatusName,
        extra: {
          'status': result.isSuccess ? 'success' : 'failed',
          'message': result.message,
        },
      );
    } catch (e) {
      if (!mounted) return;
      AppHelpers.showSnackBar(context, message: 'خطأ: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اتصال يدوي')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(labelText: 'عنوان IP', prefixIcon: Icon(Icons.lan)),
                validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _portController,
                decoration: const InputDecoration(labelText: 'المنفذ (Port)', prefixIcon: Icon(Icons.numbers)),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'مطلوب' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _connect,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('تسجيل الحضور الآن'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
