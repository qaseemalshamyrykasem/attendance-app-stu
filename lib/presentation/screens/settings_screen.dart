/// شاشة الإعدادات
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/di_setup.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/helpers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _currentTheme = 'system';
  bool _notificationsEnabled = true;
  bool _vibrationEnabled = true;
  bool _soundEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      
      final theme = await settingsRepo.getThemeMode();
      final notifications = await settingsRepo.areNotificationsEnabled();
      final vibration = await settingsRepo.isVibrationEnabled();
      final sound = await settingsRepo.isSoundEnabled();

      if (mounted) {
        setState(() {
          _currentTheme = theme ?? 'system';
          _notificationsEnabled = notifications;
          _vibrationEnabled = vibration;
          _soundEnabled = sound;
        });
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> _setTheme(String mode) async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.setThemeMode(mode);
      
      if (mounted) {
        setState(() => _currentTheme = mode);
        
        AppHelpers.showSnackBar(
          context,
          message: 'تم تغيير المظهر',
          icon: Icons.palette,
        );
      }
    } catch (e) {
      AppHelpers.showSnackBar(
        context,
        message: 'خطأ في تغيير المظهر',
        icon: Icons.error,
        backgroundColor: AppColors.error,
      );
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.toggleNotifications(value);

      if (mounted) {
        setState(() => _notificationsEnabled = value);
      }
    } catch (e) {
      AppHelpers.showSnackBar(
        context,
        message: 'خطأ في تحديث الإعدادات',
        icon: Icons.error,
        backgroundColor: AppColors.error,
      );
    }
  }

  Future<void> _toggleVibration(bool value) async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.setVibrationEnabled(value);

      if (mounted) {
        setState(() => _vibrationEnabled = value);
      }
    } catch (e) {
      debugPrint('Error updating vibration setting');
    }
  }

  Future<void> _toggleSound(bool value) async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.setSoundEnabled(value);

      if (mounted) {
        setState(() { _soundEnabled = value; });
      }
    } catch (e) {
      debugPrint('Error updating sound setting');
    }
  }

  Future<void> _resetSettings() async {
    final confirm = await AppHelpers.showConfirmDialog(
      context,
      title: 'إعادة تعيين الإعدادات',
      message: 'هل تريد إعادة جميع الإعدادات للقيم الافتراضية؟',
      confirmText: 'نعم، أعد التعيين',
    );

    if (confirm != true) return;

    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      await settingsRepo.resetSettings();
      
      _loadSettings();

      AppHelpers.showSnackBar(
        context,
        message: 'تم إعادة تعيين الإعدادات',
        icon: Icons.refresh,
      );
    } catch (e) {
      AppHelpers.showSnackBar(
        context,
        message: 'خطأ في إعادة التعيين',
        icon: Icons.error,
        backgroundColor: AppColors.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppMessages.settingsTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // قسم المظهر
          _buildSectionHeader('المظهر'),
          
          Card(
            child: Column(
              children: [
                _buildThemeOption(
                  icon: Icons.light_mode_outlined,
                  title: 'وضع فاتح',
                  subtitle: 'خلفية فاتحة وألوان هادئة',
                  value: 'light',
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  icon: Icons.dark_mode_outlined,
                  title: 'وضع داكن',
                  subtitle: 'خلفية داكنة لحماية العين',
                  value: 'dark',
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  icon: Icons.settings_suggest_outlined,
                  title: 'تلقائي (النظام)',
                  subtitle: 'اتباع إعدادات الجهاز',
                  value: 'system',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // قسم الإشعارات
          _buildSectionHeader('الإشعارات'),
          
          Card(
            child: Column(
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'الإشعارات',
                  subtitle: 'استلام إشعارات الحضور',
                  value: _notificationsEnabled,
                  onChanged: _toggleNotifications,
                ),
                const Divider(height: 1),
                _buildSwitchTile(
                  icon: Icons.vibration_outlined,
                  title: 'الاهتزاز',
                  subtitle: 'اهتزاز عند تسجيل الحضور',
                  value: _vibrationEnabled,
                  onChanged: _toggleVibration,
                ),
                const Divider(height: 1),
                _buildSwitchTile(
                  icon: Icons.volume_up_outlined,
                  title: 'الصوت',
                  subtitle: 'صوت عند تسجيل الحضور',
                  value: _soundEnabled,
                  onChanged: _toggleSound,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // قسم البيانات
          _buildSectionHeader('البيانات'),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.restore_rounded, color: Colors.orange.shade700),
                  title: const Text('إعادة تعيين الإعدادات', style: TextStyle(fontFamily: 'Cairo')),
                  subtitle: const Text('رجوع للإعدادات الافتراضية', style: TextStyle(fontFamily: 'Cairo', fontSize: 12)),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: _resetSettings,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // حول التطبيق
          _buildSectionHeader('حول'),
          
          Card(
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue.shade700),
              title: const Text(AppMessages.aboutTitle, style: TextStyle(fontFamily: 'Cairo')),
              subtitle: Text('الإصدار ${AppConstants.appVersion}', style: const TextStyle(fontFamily: 'Cairo', fontSize: 12)),
              trailing: const Icon(Icons.chevron_left),
              onTap: () => context.push('/${AppRoutes.settings}/${AppRoutes.about}'),
            ),
          ),

          const SizedBox(height: 32),

          // معلومات التطبيق
          Center(
            child: Column(
              children: [
                Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'الإصدار ${AppConstants.appVersion}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final isSelected = _currentTheme == value;

    return InkWell(
      onTap: () => _setTheme(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : Colors.grey),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontFamily: 'Cairo')),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary)
            else
              Icon(Icons.circle_outlined, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: value ? AppColors.primary : Colors.grey),
      title: Text(title, style: TextStyle(fontFamily: 'Cairo')),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontFamily: 'Cairo')),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }
}
