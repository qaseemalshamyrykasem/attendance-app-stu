/// شاشة حالة الحضور
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class AttendanceStatusScreen extends StatelessWidget {
  final String status;
  final String message;

  const AttendanceStatusScreen({
    super.key,
    required this.status,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الأيقونة المتحركة
              _buildAnimatedIcon(),

              const SizedBox(height: 32),

              // العنوان
              Text(
                _getTitle(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: _getStatusColor(),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // الرسالة
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: _getStatusColor().withValues(alpha: 0.9),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 48),

              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('رجوع', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.go('/home');
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('الرئيسية', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    switch (status.toLowerCase()) {
      case 'success':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.attendanceSuccess.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            size: 80,
            color: AppColors.attendanceSuccess,
          ),
        );
      
      case 'duplicate':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.attendanceDuplicate.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.warning_amber_rounded,
            size: 80,
            color: AppColors.attendanceDuplicate,
          ),
        );
      
      case 'session_closed':
      case 'closed':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.attendanceClosed.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.cancel_rounded,
            size: 80,
            color: AppColors.attendanceClosed,
          ),
        );
      
      case 'failed':
      case 'error':
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.attendanceError.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error_rounded,
            size: 80,
            color: AppColors.attendanceError,
          ),
        );
      
      default:
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.attendancePending.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.attendancePending),
            ),
          ),
        );
    }
  }

  String _getTitle() {
    switch (status.toLowerCase()) {
      case 'success':
        return 'تم بنجاح! ✅';
      case 'duplicate':
        return 'ملاحظة ⚠️';
      case 'session_closed':
      case 'closed':
        return 'عذراً ❌';
      case 'failed':
      case 'error':
        return 'فشل ❌';
      default:
        return 'جاري المعالجة... 🔄';
    }
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'success':
        return AppColors.attendanceSuccess;
      case 'duplicate':
        return AppColors.attendanceDuplicate;
      case 'session_closed':
      case 'closed':
        return AppColors.attendanceClosed;
      case 'failed':
      case 'error':
        return AppColors.attendanceError;
      default:
        return AppColors.attendancePending;
    }
  }
}
