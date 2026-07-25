/// شاشة حول التطبيق
library;

import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.aboutTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // الشعار
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 76.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.how_to_reg_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // اسم التطبيق
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            // الإصدار
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 25.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'الإصدار ${AppConstants.appVersion}',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontFamily: 'Cairo',
                ),
              ),
            ),

            const SizedBox(height: 8),

            // الوصف
            Text(
              AppConstants.appSubtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // المميزات
            _buildFeatureCard(
              icon: Icons.qr_code_scanner,
              title: 'مسح QR Code',
              description: 'امسح كود الجلسة لتسجيل الحضور بسرعة',
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.wifi_tethering,
              title: 'اتصال محلي',
              description: 'يعمل بدون إنترنت عبر الشبكة المحلية',
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.security,
              title: 'آمن ومشفّر',
              description: 'بيانات مشفرة مع التحقق من الهوية',
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              icon: Icons.offline_bolt,
              title: 'يعمل بدون إنترنت',
              description: 'حفظ البيانات محلياً مع إمكانية المزامنة لاحقاً',
            ),

            const SizedBox(height: 40),

            // معلومات المطور
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.code, color: Colors.blue.shade700),
                        const SizedBox(width: 12),
                        const Text(
                          'تقنيات الاستخدام',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTechChip('Flutter'),
                        _buildTechChip('Dart'),
                        _buildTechChip('Riverpod'),
                        _buildTechChip('Drift/SQLite'),
                        _buildTechChip('Go Router'),
                        _buildTechChip('Hive'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // حقوق النشر
            Text(
              '© ${DateTime.now().year} جميع الحقوق محفوظة',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                fontFamily: 'Cairo',
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 25.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade700,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
