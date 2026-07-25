/// امتدادات مخصصة لـ Dart/Flutter
library;

import 'package:flutter/material.dart';

/// امتداد على Color
extension ColorExtension on Color {
  /// تفتيح اللون
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// تغميق اللون
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// تحويل إلى سلسلة Hex
  String toHex({bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${alpha.toRadixString(16).padLeft(2, '0')}'
          '${red.toRadixString(16).padLeft(2, '0')}'
          '${green.toRadixString(16).padLeft(2, '0')}'
          '${blue.toRadixString(16).padLeft(2, '0')}';
    }
    return '#${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}

/// امتداد على BuildContext
extension ContextExtension on BuildContext {
  /// الحصول على الحجم مع مراعاة SafeArea
  Size get screenSize => MediaQuery.of(this).size;

  /// عرض الشاشة
  double get screenWidth => MediaQuery.of(this).size.width;

  /// ارتفاع الشاشة
  double get screenHeight => MediaQuery.of(this).size.height;

  /// هل هو شاشة صغيرة (هاتف)
  bool get isSmallScreen => MediaQuery.of(this).size.width < 600;

  /// هل هو جهاز لوحي
  bool get isTablet => MediaQuery.of(this).size.width >= 600 && 
                        MediaQuery.of(this).size.width < 1024;

  /// هل هو شاشة كبيرة
  bool get isLargeScreen => MediaQuery.of(this).size.width >= 1024;

  /// الوضع الداكن مفعل
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// الثيم الحالي
  ThemeData get theme => Theme.of(this);

  /// ألوان الثيم
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// نص أساسي
  TextStyle? get textThemeTitleLarge => Theme.of(this).textTheme.titleLarge;

  /// نص ثانوي
  TextStyle? get textThemeBodyMedium => Theme.of(this).textTheme.bodyMedium;

  /// إخفاء لوحة المفاتيح
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// فتح صفحة وانتظار النتيجة
  Future<T?> pushAndWait<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// العودة للصفحة السابقة
  void pop([dynamic result]) => Navigator.pop(this, result);
}

/// امتداد على DateTime
extension DateTimeExtension on DateTime {
  /// هل هو اليوم
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// هل هو أمس
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  /// بداية اليوم
  DateTime get startOfDay => DateTime(year, month, day);

  /// نهاية اليوم
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// تنسيق مخصص
  String format([String pattern = 'yyyy/MM/dd']) {
    final formats = {
      'yyyy': year.toString(),
      'MM': month.toString().padLeft(2, '0'),
      'dd': day.toString().padLeft(2, '0'),
      'HH': hour.toString().padLeft(2, '0'),
      'mm': minute.toString().padLeft(2, '0'),
      'ss': second.toString().padLeft(2, '0'),
    };
    
    var result = pattern;
    formats.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }
}

/// امتداد على List
extension ListExtension<T> on List<T> {
  /// تقسيم القائمة إلى مجموعات
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      final end = (i + size > length) ? length : i + size;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  /// هل القائمة فارغة أو null
  bool get isNullOrEmpty => isEmpty;
  
  /// هل القائمة ليست فارغة
  bool get isNotEmptyOrNull => isNotEmpty;
}
