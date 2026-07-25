/// أدوات مساعدة عامة
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class AppHelpers {
  AppHelpers._();

  /// تنسيق التاريخ والوقت
  static String formatDateTime(DateTime dateTime, {String pattern = 'yyyy/MM/dd HH:mm'}) {
    return DateFormat(pattern).format(dateTime);
  }

  /// تنسيق التاريخ فقط
  static String formatDate(DateTime dateTime, {String pattern = 'yyyy/MM/dd'}) {
    return DateFormat(pattern).format(dateTime);
  }

  /// تنسيق الوقت فقط
  static String formatTime(DateTime dateTime, {String pattern = 'HH:mm'}) {
    return DateFormat(pattern).format(dateTime);
  }

  /// الحصول على الوقت النسبي (منذ متى)
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} سنة';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} شهر';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }

  /// التحقق من صحة عنوان IP
  static bool isValidIp(String ip) {
    final ipRegex = RegExp(
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',
    );
    return ipRegex.hasMatch(ip.trim());
  }

  /// التحقق من صحة رقم المنفذ
  static bool isValidPort(String port) {
    final portNum = int.tryParse(port.trim());
    return portNum != null && portNum >= 1 && portNum <= 65535;
  }

  /// التحقق من صحة الرقم الجامعي
  static bool isValidStudentId(String studentId) {
    return studentId.trim().isNotEmpty && studentId.trim().length >= 4;
  }

  /// إخفاء جزء من الرقم (للخصوصية)
  static String maskString(String value, {int visibleChars = 4}) {
    if (value.length <= visibleChars) return value;
    final masked = '*' * (value.length - visibleChars);
    return masked + value.substring(value.length - visibleChars);
  }

  /// إنشاء فريد من نوعه بسيط
  static String generateSimpleId() {
    final now = DateTime.now();
    return '${now.millisecondsSinceEpoch}_${now.microsecond}';
  }

  /// حساب لون من نص (للأفاتار)
  static Color colorFromString(String string) {
    int hash = 0;
    for (int i = 0; i < string.length; i++) {
      hash = string.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
    ];
    return colors[hash.abs() % colors.length];
  }

  /// عرض SnackBar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: duration,
      ),
    );
  }

  /// عرض حوار تأكيد
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'نعم',
    String cancelText = 'إلغاء',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontFamily: 'Cairo')),
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText, style: const TextStyle(fontFamily: 'Cairo')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: confirmColor ?? Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// امتداد على String للتحقق السريع
extension StringValidation on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  
  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;
}
