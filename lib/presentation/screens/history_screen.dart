/// شاشة سجل الحضور
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/di_setup.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';
import '../../domain/entities/attendance_entity.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  List<AttendanceEntity> _records = [];
  bool _isLoading = true;
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords({String? statusFilter}) async {
    setState(() => _isLoading = true);
    
    try {
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      
      List<AttendanceEntity> records;
      if (statusFilter != null && statusFilter.isNotEmpty) {
        records = await attendanceRepo.searchRecords(statusFilter: statusFilter);
      } else {
        records = await attendanceRepo.getAttendanceHistory(limit: 100);
      }
      
      if (mounted) {
        setState(() {
          _records = records;
          _isLoading = false;
          _statusFilter = statusFilter;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _clearHistory() async {
    final confirm = await AppHelpers.showConfirmDialog(
      context,
      title: 'مسح السجل',
      message: 'هل أنت متأكد من مسح جميع سجلات الحضور؟',
      confirmText: 'نعم، امسح',
    );

    if (confirm != true) return;

    try {
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      await attendanceRepo.clearHistory();
      
      AppHelpers.showSnackBar(
        context,
        message: AppMessages.dataCleared,
        icon: Icons.delete_sweep,
      );
      
      _loadRecords();
    } catch (e) {
      AppHelpers.showSnackBar(
        context,
        message: 'خطأ في مسح البيانات',
        icon: Icons.error,
        backgroundColor: AppColors.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.historyTitle),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                _clearHistory();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text('مسح الكل', style: TextStyle(fontFamily: 'Cairo')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // فلتر الحالة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 12.8),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('الكل', null),
                        const SizedBox(width: 8),
                        _buildFilterChip('ناجح', AppConstants.statusPresent),
                        const SizedBox(width: 8),
                        _buildFilterChip('فاشل', 'failed'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // قائمة السجلات
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _records.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: () => _loadRecords(statusFilter: _statusFilter),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _records.length,
                          itemBuilder: (context, index) {
                            return _buildRecordCard(_records[index]);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String? value) {
    final isSelected = _statusFilter == value;
    
    return FilterChip(
      label: Text(label, style: TextStyle(fontFamily: 'Cairo')),
      selected: isSelected,
      onSelected: (selected) {
        _loadRecords(statusFilter: selected ? value : null);
      },
      selectedColor: AppColors.primary.withValues(alpha: 51.0),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.grey.shade600,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'لا يوجد سجلات حضور',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ بتسجيل حضورك لظهوره هنا',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(AttendanceEntity record) {
    final isSuccess = record.isSuccess && record.status == 'present';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showRecordDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // أيقونة الحالة
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSuccess 
                      ? AppColors.success.withValues(alpha: 25.5)
                      : AppColors.error.withValues(alpha: 25.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle : Icons.cancel,
                  color: isSuccess ? AppColors.success : AppColors.error,
                ),
              ),

              const SizedBox(width: 16),

              // التفاصيل
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.message.isNotEmpty ? record.message : 'تسجيل حضور',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(record.date),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.access_time, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(
                          record.time,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // سهم التفاصيل
              Icon(
                Icons.chevron_left,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRecordDetails(AttendanceEntity record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط السحب
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // العنوان
            Row(
              children: [
                Icon(
                  record.isSuccess ? Icons.check_circle : Icons.info,
                  color: record.isSuccess ? AppColors.success : AppColors.info,
                ),
                const SizedBox(width: 12),
                Text(
                  'تفاصيل التسجيل',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // معرف الجلسة
            _buildDetailRow('معرف الجلسة', record.sessionId ?? 'غير محدد'),
            const Divider(),
            
            // اسم المادة
            _buildDetailRow('المادة/الجلسة', record.courseName ?? 'غير محدد'),
            const Divider(),

            // التاريخ
            _buildDetailRow('التاريخ', _formatDate(record.date)),
            const Divider(),

            // الوقت
            _buildDetailRow('الوقت', record.time),
            const Divider(),

            // الحالة
            _buildDetailRow('الحالة', record.statusArabic),
            const Divider(),

            // الرسالة
            _buildDetailRow('الرسالة', record.message),

            const SizedBox(height: 24),

            // زر الإغلاق
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
