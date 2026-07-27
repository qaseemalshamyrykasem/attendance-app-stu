# إصلاح فشل التحضير بين تطبيق الطالب والمندوب

## المشكلة
عند محاولة الطالب تسجيل الحضور عبر مسح QR Code أو الاتصال اليدوي، تفشل العملية ولا يتم التسجيل.

## الأسباب الجذرية (3 مشاكل متسلسلة)

### 🔴 المشكلة 1: عدم توافق صيغة QR Code
> [!CAUTION]
> هذه المشكلة الأساسية — تطبيق الطالب لا يستطيع قراءة QR أصلاً

| | تطبيق المندوب (يولّد) | تطبيق الطالب (يقرأ) |
|---|---|---|
| **الصيغة** | Base64 JSON: `{"token":"...", "ip":"...", "port":"...", "type":"...", "ts":"..."}` | نص بسيط: `ip:port:sessionId` |
| **الملف** | [encryption_service.dart](file:///home/qaseem/Documents/Attendance/attendance_app-admin/lib/services/encryption/encryption_service.dart#L137-L150) | [scan_qr_screen.dart](file:///home/qaseem/Documents/Attendance/attendance-stu-app/lib/presentation/screens/scan_qr_screen.dart#L70-L83) |

---

### 🔴 المشكلة 2: إرسال sessionId بدلاً من session_token
حتى لو وصل الاتصال للمندوب، الطالب يرسل `sessionId` كـ `session_token`:

```dart
// attendance_repository_impl.dart سطر 33
'session_token': sessionToken ?? sessionId,  // sessionToken دائماً null!
```

بينما المندوب يتحقق من التوكن:
```dart
// http_server_service.dart سطر 220
if (checkInRequest.sessionToken != _currentSessionToken) → 401 Unauthorized
```

---

### 🟡 المشكلة 3: خطأ في `isStudentCheckedIn`
```dart
// providers.dart سطر 546-548
final alreadyCheckedIn = await _database.isStudentCheckedIn(
  request.sessionToken.isNotEmpty ? request.sessionToken : ...,
  // ↑ يمرر التوكن كـ sessionId — دائماً يرجع false (ليس خطيراً لكن خاطئ)
```

---

## الإصلاحات المطلوبة

### [MODIFY] [scan_qr_screen.dart](file:///home/qaseem/Documents/Attendance/attendance-stu-app/lib/presentation/screens/scan_qr_screen.dart)
- تعديل `_parseQRData` لدعم صيغة Base64 JSON التي يرسلها المندوب
- استخراج `token` و `ip` و `port` من البيانات المفكوكة
- تمرير `sessionToken` الحقيقي إلى `submitAttendance`
- الحفاظ على التوافق مع الصيغة القديمة (fallback)

### [MODIFY] [attendance_repository_impl.dart](file:///home/qaseem/Documents/Attendance/attendance-stu-app/lib/data/repositories/attendance_repository_impl.dart)
- إضافة `sessionToken` كمعامل حقيقي يُمرّر للطلب
- ضمان إرسال التوكن الصحيح في `payload['session_token']`

### [MODIFY] [attendance_repository.dart](file:///home/qaseem/Documents/Attendance/attendance-stu-app/lib/domain/repositories/attendance_repository.dart)
- تحديث الـ interface ليشمل `sessionToken`

### [MODIFY] [providers.dart](file:///home/qaseem/Documents/Attendance/attendance_app-admin/lib/core/di/providers.dart)
- إصلاح `_handleCheckIn` لاستخدام session ID الفعلي بدلاً من التوكن في `isStudentCheckedIn`

## خطة التحقق
- مراجعة تدفق البيانات كاملاً من QR → parse → send → receive → process
- التأكد من تطابق أسماء الحقول بين التطبيقين
