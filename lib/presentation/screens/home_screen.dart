/// الشاشة الرئيسية
library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/di_setup.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/attendance_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  AttendanceModel? _lastAttendance;

  @override
  void initState() {
    super.initState();
    _loadLastAttendance();
  }

  Future<void> _loadLastAttendance() async {
    try {
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final history = await attendanceRepo.getAttendanceHistory(limit: 1);
      if (history.isNotEmpty && mounted) {
        setState(() {
          // تحويل Entity إلى Model للعرض
          _lastAttendance = AttendanceModel(
            id: history.first.id,
            sessionId: history.first.sessionId,
            courseName: history.first.courseName,
            date: history.first.date,
            time: history.first.time,
            status: history.first.status,
            serverResponse: history.first.message,
          );
        });
      }
    } catch (e) {
      debugPrint('Error loading last attendance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadLastAttendance,
        child: CustomScrollView(
          slivers: [
            // Header مع ترحيب
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            
            // المحتوى الرئيسي
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // حالة آخر حضور
                  _buildLastAttendanceCard(),
                  
                  const SizedBox(height: 24),
                  
                  // الأزرار السريعة
                  _buildQuickActions(),
                  
                  const SizedBox(height: 24),
                  
                  // إحصائيات سريعة
                  _buildStatsCard(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FutureBuilder(
      future: ref.read(studentRepositoryProvider).getStudent(),
      builder: (context, snapshot) {
        final student = snapshot.data;
        final greeting = _getGreeting();
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // الأفاتار
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: student?.photoPath != null
                        ? ClipOval(
                            child: Image.file(
                              File(student!.photoPath!),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildDefaultAvatar(student),
                            ),
                          )
                        : _buildDefaultAvatar(student),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          student?.name ?? 'مرحباً',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // أيقونة الإشعار
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDefaultAvatar(dynamic student) {
    return Text(
      student?.initials ?? 'ط',
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Cairo',
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير 👋';
    if (hour < 17) return 'مساء الخير 👋';
    return 'مساء الخير 🌙';
  }

  Widget _buildLastAttendanceCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'آخر تسجيل حضور',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
                Icon(
                  Icons.history,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_lastAttendance != null) ...[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: getStatusColor(_lastAttendance!.status).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getStatusIcon(_lastAttendance!.status),
                      color: getStatusColor(_lastAttendance!.status),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _lastAttendance!.serverResponse.isNotEmpty
                              ? _lastAttendance!.serverResponse
                              : 'تم التسجيل',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(_lastAttendance!),
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
            ] else ...[
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      size: 48,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'لا يوجد سجلات حضور بعد',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade500,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.push('/home/${AppRoutes.scan}'),
                      child: const Text(
                        'ابدأ بتسجيل الحضور الآن',
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'إجراءات سريعة',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildActionCard(
              icon: Icons.qr_code_scanner_rounded,
              title: 'مسح QR Code',
              subtitle: 'امسح كود الجلسة',
              color: AppColors.primary,
              onTap: () => context.push('/home/${AppRoutes.scan}'),
            ),
            _buildActionCard(
              icon: Icons.wifi_tethering_rounded,
              title: 'اتصال يدوي',
              subtitle: 'أدخل البيانات يدوياً',
              color: AppColors.secondary,
              onTap: () => context.push('/home/${AppRoutes.connect}'),
            ),
            _buildActionCard(
              icon: Icons.history_edu_rounded,
              title: 'سجل الحضور',
              subtitle: 'عرض السجلات',
              color: Colors.blue.shade700,
              onTap: () => context.go(AppRoutes.history),
            ),
            _buildActionCard(
              icon: Icons.person_search_rounded,
              title: 'ملفي الشخصي',
              subtitle: 'عرض وتعديل البيانات',
              color: Colors.purple.shade700,
              onTap: () => context.go(AppRoutes.profile),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return FutureBuilder(
      future: ref.read(attendanceRepositoryProvider).getAttendanceCount(),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                value: count.toString(),
                label: 'إجمالي التسجيلات',
                icon: Icons.fact_check_outlined,
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.white.withOpacity(0.3),
              ),
              _buildStatItem(
                value: _getThisMonthCount(count),
                label: 'هذا الشهر',
                icon: Icons.calendar_month_outlined,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  String _getThisMonthCount(int total) {
    // بسيط - في الإنتاج احسب فعلياً
    return (total * 0.7).round().toString();
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Icons.check_circle;
      case 'failed':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDateTime(AttendanceModel record) {
    if (record.date == null) return '';
    final date = '${record.date!.year}/${record.date!.month.toString().padLeft(2, '0')}/${record.date!.day.toString().padLeft(2, '0')}';
    final time = record.time ?? '';
    return '$date $time';
  }
}
