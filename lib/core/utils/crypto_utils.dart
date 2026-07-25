/// أدوات التشفير والأمان
library;

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class CryptoUtils {
  CryptoUtils._();

  /// إنشاء SHA256 Hash للنص
  static String sha256(String input) {
    final bytes = utf8.encode(input);
    final hash = crypto.sha256.convert(bytes);
    return hash.toString();
  }

  /// إنشاء Hash للبيانات المرسلة
  /// يتضمن: student_id + timestamp + secret_key
  static String generateAttendanceHash({
    required String studentId,
    required String timestamp,
    String secretKey = 'attendance_secret_2024',
  }) {
    final data = '$studentId:$timestamp:$secretKey';
    return sha256(data);
  }

  /// التحقق من صحة الهاش
  static bool verifyHash({
    required String data,
    required String hash,
  }) {
    return sha256(data) == hash;
  }

  /// تشفير بسيط (Base64)
  static String encode(String input) {
    final bytes = utf8.encode(input);
    return base64.encode(bytes);
  }

  /// فك التشفير البسيط
  static String decode(String encoded) {
    final bytes = base64.decode(encoded);
    return utf8.decode(bytes);
  }
}
