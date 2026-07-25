/// حالات استخدام الإعدادات
library;

import '../repositories/settings_repository.dart';

/// حالة استخدام الحصول على وضع الثيم
class GetThemeModeUseCase {
  final SettingsRepository _repository;

  GetThemeModeUseCase(this._repository);

  Future<String?> call() async {
    return await _repository.getThemeMode();
  }
}

/// حالة استخدام تعيين وضع الثيم
class SetThemeModeUseCase {
  final SettingsRepository _repository;

  SetThemeModeUseCase(this._repository);

  Future<void> call(String mode) async {
    await _repository.setThemeMode(mode);
  }
}

/// حالة استخدام التحقق من الإشعارات
class AreNotificationsEnabledUseCase {
  final SettingsRepository _repository;

  AreNotificationsEnabledUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.areNotificationsEnabled();
  }
}

/// حالة استخدام تفعيل/إلغاء الإشعارات
class ToggleNotificationsUseCase {
  final SettingsRepository _repository;

  ToggleNotificationsUseCase(this._repository);

  Future<void> call(bool value) async {
    await _repository.toggleNotifications(value);
  }
}

/// حالة استخدام التحقق من الاهتزاز
class IsVibrationEnabledUseCase {
  final SettingsRepository _repository;

  IsVibrationEnabledUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isVibrationEnabled();
  }
}

/// حالة استخدام تفعيل/إلغاء الاهتزاز
class SetVibrationEnabledUseCase {
  final SettingsRepository _repository;

  SetVibrationEnabledUseCase(this._repository);

  Future<void> call(bool value) async {
    await _repository.setVibrationEnabled(value);
  }
}

/// حالة استخدام التحقق من الصوت
class IsSoundEnabledUseCase {
  final SettingsRepository _repository;

  IsSoundEnabledUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isSoundEnabled();
  }
}

/// حالة استخدام تفعيل/إلغاء الصوت
class SetSoundEnabledUseCase {
  final SettingsRepository _repository;

  SetSoundEnabledUseCase(this._repository);

  Future<void> call(bool value) async {
    await _repository.setSoundEnabled(value);
  }
}

/// حالة استخدام إعادة تعيين الإعدادات
class ResetSettingsUseCase {
  final SettingsRepository _repository;

  ResetSettingsUseCase(this._repository);

  Future<void> call() async {
    await _repository.resetSettings();
  }
}
