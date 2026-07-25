/// نموذج الإعدادات
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required String key,
    required String value,
    @Default('string') String type,
    DateTime? updatedAt,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  /// إنشاء نموذج فارغ
  factory SettingsModel.empty() => const SettingsModel(
        key: '',
        value: '',
      );
}

/// مفاتيح الإعدادات
class SettingKeys {
  static const String themeMode = 'theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String autoScan = 'auto_scan';
  static const String vibrationEnabled = 'vibration_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String lastIpAddress = 'last_ip_address';
  static const String lastPort = 'last_port';
}

/// قيم الوضع الافتراضية
class DefaultSettings {
  static const String defaultThemeMode = 'system';
  static const bool defaultNotificationsEnabled = true;
  static const bool defaultAutoScan = false;
  static const bool defaultVibrationEnabled = true;
  static const bool defaultSoundEnabled = true;
}
