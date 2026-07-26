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
    final studentAsync = ref.watch(currentStudentProvider);

    return Scaffold(
      body: studentAsync.when(
        data: (student) => RefreshIndicator(
          onRefresh: () async {
            await _loadLastAttendance();
            ref.invalidate(currentStudentProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context, student),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildLastAttendanceCard(),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                    const SizedBox(height: 24),
                    _buildStatsCard(),
                  ]),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('خطأ في تحميل البيانات: $err')),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic student) {
    final hour = DateTime.now().hour;
    String greeting = hour < 12 ? 'صباح الخير 👋' : 'مساء الخير 👋';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
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
                    color: Colors.white.withValues(alpha: 0.8),
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  student?.name ?? 'طالب عزيز',
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
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(dynamic student) {
    return const Icon(Icons.person, color: Colors.white, size: 30);
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
            const Text(
              'آخر تسجيل حضور',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 16),
            if (_lastAttendance != null)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.success.withValues(alpha: 0.1),
                  child: const Icon(Icons.check_circle, color: AppColors.success),
                ),
                title: Text(_lastAttendance!.courseName.isNotEmpty ? _lastAttendance!.courseName : 'تم التسجيل'),
                subtitle: Text('${_lastAttendance!.date?.year}/${_lastAttendance!.date?.month}/${_lastAttendance!.date?.day} - ${_lastAttendance!.time}'),
              )
            else
              const Center(child: Text('لا يوجد سجلات بعد', style: TextStyle(fontFamily: 'Cairo', color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
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
          color: AppColors.primary,
          onTap: () => context.pushNamed(AppRoutes.scanName),
        ),
        _buildActionCard(
          icon: Icons.wifi_tethering_rounded,
          title: 'اتصال يدوي',
          color: AppColors.secondary,
          onTap: () => context.pushNamed(AppRoutes.connectName),
        ),
      ],
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: AppColors.primary),
          SizedBox(width: 12),
          Text('نظام الحضور الذكي - نسخة الطالب', style: TextStyle(fontFamily: 'Cairo')),
        ],
      ),
    );
  }
}
