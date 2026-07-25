# 📡 توثيق API - Admin Server

<p align="center">
  <img src="https://img.shields.io/badge/Protocol-HTTP-009639?style=flat-square" alt="HTTP" />
  <img src="https://img.shields.io/badge/Format-JSON-000000?style=flat-square" alt="JSON" />
  <img src="https://img.shields.io/badge/Network-Local_WiFi-4CAF50?style=flat-square" alt="WiFi" />
  <img src="https://img.shields.io/badge/Port-8080-FF9800?style=flat-square" alt="Port" />
</p>

---

## 📋 جدول المحتويات

- [📖 نظرة عامة](#-نظرة-عامة)
- [🔗 الاتصال بالخادم](#-الاتصال-بالخادم)
- [📤 نقاط النهاية (Endpoints)](#-نقاط-النهاية-endpoints)
  - [تسجيل الحضور (Check-in)](#--تسجيل-الحضور-check-in)
  - [فحص صحة الخادم (Health Check)](#--فحص-صحة-الخادم-health-check)
  - [معلومات الجلسة (Session Info)](#--معلومات-الجلسة-session-info)
- [🔐 التشفير والأمان](#-التشفير-والأمان)
- [📨 تنسيق الطلبات والاستجابات](#-تنسيق-الطلبات-والاستجابات)
- [⚠️ حالات الخطأ والحلول](#-حالات-الخطأ-والحلول)
- [🧪 أمثلة الاستخدام](#-أمثلة-الاستخدام)

---

## 📖 نظرة عامة

يتصل تطبيق الطالب بخادم **Admin App** عبر الشبكة المحلية (WiFi) لإرسال بيانات الحضور. يستخدم التطبيق **HTTP REST API** مع تبادل البيانات بصيغة **JSON**.

### 🔄 سير العمل

```
┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   الطالب     │      │   الشبكة     │      │   المندوب    │
│              │      │   المحلية    │      │              │
│ 1. مسح QR   │─────►│              │◄─────│ 1. عرض QR   │
│ 2. قراءة IP │      │   WiFi/LAN   │      │ 2. تشغيل    │
│ 3. إرسال    │─────►│              │─────►│    الخادم    │
│    الحضور   │      │              │      │ 3. استقبال  │
│ 4. انتظار   │◄─────│              │◄─────│    وتسجيل   │
│    التأكيد  │      │              │      │ 4. رد       │
└──────────────┘      └──────────────┘      └──────────────┘
```

---

## 🔗 الاتصال بالخادم

### معلومات الاتصال الأساسية

| الخاصية | القيمة |
|---------|--------|
| **البروتوكول** | HTTP |
| **المنفذ الافتراضي** | `8080` |
| **العنوان** | IP محلي (مثال: `192.168.1.100`) |
| **المهلة** | 10 ثواني (اتصال)، 15 ثانية (استقبال) |

### عنوان URL الأساسي

```
http://{IP}:{PORT}/api/
```

**مثال:**
```
http://192.168.1.100:8080/api/
```

### الرؤوس (Headers)

كل طلب يتضمن هذه الرؤوس:

```http
Content-Type: application/json
Accept: application/json
User-Agent: AttendanceStudent/1.0
```

### كيف يحصل التطبيق على عنوان الخادم

**الطريقة الأولى: من QR Code**

يحتوي QR Code على:
```json
{
  "ip": "192.168.1.100",
  "port": 8080,
  "sessionId": "session_abc123"
}
```

**الطريقة الثانية: الإدخال اليدوي**

يدخل المستخدم:
- IP Address
- Port Number
- Session ID (اختياري)

---

## 📤 نقاط النهاية (Endpoints)

### ✅ تسجيل الحضور (Check-in)

إرسال بيانات حضور طالب جديدة للخادم.

#### المعلومات الأساسية

| الخاصية | القيمة |
|---------|--------|
| **الطريقة** | `POST` |
| **المسار** | `/api/attendance/check-in` |
| **Content-Type** | `application/json` |

#### الطلب (Request Body)

```json
{
  "student_id": "2024001234",
  "name": "أحمد محمد العلي",
  "department": "علوم الحاسب",
  "level": "المستوى الثالث",
  "section": "أ",
  "device_id": "unique_device_id_12345",
  "timestamp": "2024-01-15T08:30:00.000Z",
  "hash": "a1b2c3d4e5f6...",
  "session_id": "session_abc123"
}
```

#### وصف حقول الطلب

| الحقل | النوع | مطلوب | الوصف |
|-------|------|-------|-------|
| `student_id` | String | ✅ نعم | الرقم الجامعي أو المعرف الفريد للطالب |
| `name` | String | ✅ نعم | الاسم الكامل للطالب |
| `department` | String | ✅ نعم | القسم الدراسي |
| `level` | String | ✅ نعم | المستوى الدراسي |
| `section` | String | ✅ نعم | رقم/اسم الشعبة |
| `device_id` | String | ✅ نعم | معرف فريد لجهاز الطالب |
| `timestamp` | String | ✅ نعم | وقت الإرسال بصيغة ISO 8601 |
| `hash` | String | ✅ نعم | توقيع رقمي للبيانات (SHA-256) |
| `session_id` | String | ❌ لا | معرف جلسة الحضور (إن وجد) |

#### الاستجابة الناجحة (200 OK)

```json
{
  "success": true,
  "message": "تم تسجيل حضورك بنجاح",
  "attendance_id": "att_789xyz",
  "session_id": "session_abc123",
  "data": {
    "course_name": "هياكل البيانات",
    "check_in_time": "08:30:15",
    "status": "present"
  }
}
```

#### وصف حقول الاستجابة الناجحة

| الحقل | النوع | الوصف |
|-------|------|-------|
| `success` | Boolean | دائماً `true` |
| `message` | String | رسالة نجاح |
| `attendance_id` | String | معرف سجل الحضور المُنشأ |
| `session_id` | String | معرف الجلسة |
| `data` | Object | بيانات إضافية (اختياري) |
| `data.course_name` | String | اسم المقرر |
| `data.check_in_time` | String | وقت التسجيل |
| `data.status` | String | حالة الحضور |

#### الاستجابات الخطأ

**400 Bad Request - بيانات غير صحيحة**

```json
{
  "success": false,
  "message": "بيانات غير صحيحة أو ناقصة"
}
```

**409 Conflict - مسجل مسبقاً**

```json
{
  "success": false,
  "message": "أنت مسجل مسبقاً في هذه الجلسة"
}
```

**410 Gone - الجلسة مغلقة**

```json
{
  "success": false,
  "message": "انتهت وقت التسجيل في هذه الجلسة"
}
```

**500 Internal Server Error - خطأ في الخادم**

```json
{
  "success": false,
  "message": "خطأ داخلي في الخادم، يرجى المحاولة لاحقاً"
}
```

---

### 💚 فحص صحة الخادم (Health Check)

للتحقق من أن الخادم يعمل ومتاح.

#### المعلومات الأساسية

| الخاصية | القيمة |
|---------|--------|
| **الطريقة** | `GET` |
| **المسار** | `/api/health` |
| **المعاملات** | لا يوجد |

#### الطلب

```bash
curl http://192.168.1.100:8080/api/health
```

#### الاستجابة الناجحة (200 OK)

```json
{
  "status": "ok",
  "server_time": "2024-01-15T08:30:00.000Z",
  "version": "1.0.0",
  "active_sessions": 3
}
```

#### الاستجابة عند عدم التوفر

- **Connection Timeout**: الخادم لا يستجيب
- **Connection Refused**: الخادم مغلق
- **503 Service Unavailable**: الخادم مشغول

---

### 📋 معلومات الجلسة (Session Info)

للحصول على تفاصيل جلسة حضور محددة.

#### المعلومات الأساسية

| الخاصية | القيمة |
|---------|--------|
| **الطريقة** | `GET` |
| **المسار** | `/api/session/{sessionId}` |

#### الطلب

```bash
curl http://192.168.1.100:8080/api/session/session_abc123
```

#### الاستجابة الناجحة (200 OK)

```json
{
  "session_id": "session_abc123",
  "course_name": "هياكل البيانات",
  "instructor_name": "د. محمد أحمد",
  "start_time": "2024-01-15T08:00:00.000Z",
  "end_time": "2024-01-15T09:00:00.000Z",
  "status": "active",
  "registered_count": 25,
  "max_students": 40
}
```

#### وصف حقول الجلسة

| الحقل | النوع | الوصف |
|-------|------|-------|
| `session_id` | String | معرف الجلسة |
| `course_name` | String | اسم المقرر |
| `instructor_name` | String | اسم المحاضر |
| `start_time` | DateTime | وقت بدء الجلسة |
| `end_time` | DateTime | وقت انتهاء الجلسة |
| `status` | String | حالة الجلسة (`active`, `closed`, `pending`) |
| `registered_count` | int | عدد المسجلين |
| `max_students` | int | الحد الأقصى للطلاب |

---

## 🔐 التشفير والأمان

### خوارزمية التشفير

يستخدم التطبيق **SHA-256** لتوقيع البيانات قبل الإرسال:

```dart
import 'package:crypto/crypto.dart';
import 'dart:convert';

String generateHash(Map<String, dynamic> data, String secretKey) {
  // ترتيب البيانات
  final sortedData = Map.fromEntries(
    data.entries.toList()..sort((a, b) => a.key.compareTo(b.key))
  );
  
  // إنشاء النص المراد تشفيره
  final message = sortedData.values.join('|') + secretKey;
  
  // حساب الـ Hash
  var bytes = utf8.encode(message);
  var digest = sha256.convert(bytes);
  
  return digest.toString();
}
```

### تنسيق الـ Hash

```
hash = SHA256(student_id|name|department|level|section|device_id|timestamp|secret_key)
```

### التحقق من الخادم

يتحقق الخادم من:
1. صحة تنسيق البيانات
2. سلامة الـ Hash
3. عدم تكرار الطلب (Idempotency)
4. صلاحية الوقت (ضمن نافذة الجلسة)

---

## 📨 تنسيق الطلبات والاستجابات

### نموذج الطلب (AttendanceRequest)

```dart
@freezed
class AttendanceRequest with _$AttendanceRequest {
  const factory AttendanceRequest({
    required String studentId,     // student_id
    required String name,          // name
    required String department,    // department
    required String level,         // level
    required String section,       // section
    required String deviceId,      // device_id
    required String timestamp,     // timestamp
    required String hash,          // hash
    String? sessionId,             // session_id (optional)
  }) = _AttendanceRequest;
  
  // تحويل لـ JSON للـ API
  Map<String, dynamic> toJsonForApi() => {
    'student_id': studentId,
    'name': name,
    'department': department,
    'level': level,
    'section': section,
    'device_id': deviceId,
    'timestamp': timestamp,
    'hash': hash,
    if (sessionId != null) 'session_id': sessionId,
  };
}
```

### نموذج الاستجابة (ServerResponse)

```dart
@freezed
class ServerResponse with _$ServerResponse {
  const factory ServerResponse({
    @Default(false) bool success,
    @Default('') String message,
    String? attendanceId,        // attendance_id
    String? sessionId,           // session_id
    DateTime? timestamp,
    @Default(null) dynamic data, // بيانات إضافية
  }) = _ServerResponse;
  
  // إنشاء استجابة ناجحة
  factory ServerResponse.successResponse({
    required String message,
    String? attendanceId,
    String? sessionId,
  });
  
  // إنشاء استجابة فاشلة
  factory ServerResponse.errorResponse({
    required String message,
  });
}
```

---

## ⚠️ حالات الخطأ والحلول

### جدول أكواد الحالة

| الكود | المعنى | السبب المحتمل | الحل |
|-------|--------|---------------|------|
| **200** | نجاح | تم التسجيل بنجاح | - |
| **201** | تم الإنشاء | سجل جديد أُنشئ | - |
| **400** | طلب خاطئ | بيانات ناقصة أو غير صحيحة | تحقق من جميع الحقول المطلوبة |
| **409** | تعارض | الطالب مسجل مسبقاً | لا حاجة لإعادة التسجيل |
| **410** | غير متاح | الجلسة مغلقة | تواصل مع المندوب |
| **500** | خطأ داخلي | مشكلة في الخادم | أعد المحاولة لاحقاً |
| **502** | بوابة سيئة | الخادم غير متاح | تحقق من اتصال الشبكة |
| **503** | خدمة غير متاحة | الخادم تحت الصيانة | انتظر ثم أعد المحاولة |

### أخطاء الاتصال

#### SocketException - لا يمكن الاتصال

```
❌ رسالة الخطأ: "تأكد من اتصالك بشبكة المندوب"

🔍 الأسباب المحتملة:
- IP address غير صحيح
- الخادم غير يعمل
- ليس على نفس الشبكة
- Firewall يحجب الاتصال

✅ الحلول:
1. تأكد من IP الصحيح
2. تأكد من تشغيل تطبيق المندوب
3. تأكد من الاتصال بنفس WiFi
4. جرب ping للخادم
```

#### TimeoutException - انتهت المهلة

```
❌ رسالة الخطأ: "انتهت مهلة الاتصال، تأكد من أن الخادم يعمل"

🔍 الأسباب المحتملة:
- الخادم بطيء
- ضعف إشارة الشبكة
- كمية كبيرة من الطلبات

✅ الحلول:
1. اقترب من نقطة الوصول (Router)
2. أعد المحاولة
3. قلل عدد الأجهزة المتصلة
```

#### FormatException - استجابة غير صالحة

```
❌ رسالة الخطأ: "استجابة غير صالحة من الخادم"

🔍 الأسباب المحتملة:
- إصدار API غير متوافق
- مشكلة في تشفير البيانات

✅ الحلول:
1. حدث التطبيق
2. تواصل مع المسؤول
```

### التعامل مع الأخطاء في الكود

```dart
try {
  final response = await httpClient.postAttendance(
    ipAddress: ip,
    port: port,
    data: requestData,
  );
  
  if (response.success) {
    // عرض رسالة النجاح
    showSuccess(response.message);
  } else {
    // عرض رسالة الخطأ من الخادم
    showError(response.message);
  }
} on SocketException catch (_) {
  showError('تأكد من اتصالك بشبكة المندوب');
} on TimeoutException catch (_) {
  showError('انتهت مهلة الاتصال');
} catch (e) {
  showError('حدث خطأ غير متوقع: $e');
}
```

---

## 🧪 أمثلة الاستخدام

### مثال 1: تسجيل حضور كامل

```dart
import 'package:attendance_student/services/network/http_client.dart';

void submitAttendanceExample() async {
  final httpClient = HttpClient();
  
  // بيانات الحضور
  final attendanceData = {
    'student_id': '2024001234',
    'name': 'أحمد محمد',
    'department': 'علوم الحاسب',
    'level': 'المستوى الثالث',
    'section': 'أ',
    'device_id': 'device_abc123',
    'timestamp': DateTime.now().toIso8601String(),
    'hash': 'generated_sha256_hash...',
    'session_id': 'session_xyz789',
  };
  
  try {
    final response = await httpClient.postAttendance(
      ipAddress: '192.168.1.100',
      port: 8080,
      data: attendanceData,
    );
    
    print('Success: ${response.success}');
    print('Message: ${response.message}');
    print('Attendance ID: ${response.attendanceId}');
    
  } catch (e) {
    print('Error: $e');
  }
}
```

### مثال 2: فحص الاتصال

```dart
Future<bool> checkServerConnection() async {
  final httpClient = HttpClient();
  
  final isConnected = await httpClient.checkConnection(
    ipAddress: '192.168.1.100',
    port: 8080,
  );
  
  if (isConnected) {
    print('✅ الخادم متاح');
    return true;
  } else {
    print('❌ لا يمكن الوصول للخادم');
    return false;
  }
}
```

### مثال 3: الحصول على معلومات الجلسة

```dart
Future<void> getSessionDetails(String sessionId) async {
  final httpClient = HttpClient();
  
  final sessionInfo = await httpClient.getSessionInfo(
    ipAddress: '192.168.1.100',
    port: 8080,
    sessionId: sessionId,
  );
  
  if (sessionInfo != null) {
    print('المقرر: ${sessionInfo['course_name']}');
    print('المحاضر: ${sessionInfo['instructor_name']}');
    print('الحالة: ${sessionInfo['status']}');
  }
}
```

### مثال 4: استخدام cURL

```bash
# تسجيل حضور
curl -X POST \
  http://192.168.1.100:8080/api/attendance/check-in \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "student_id": "2024001234",
    "name": "أحمد محمد",
    "department": "علوم الحاسب",
    "level": "المستوى الثالث",
    "section": "أ",
    "device_id": "test_device_001",
    "timestamp": "2024-01-15T08:30:00.000Z",
    "hash": "abc123def456...",
    "session_id": "session_test"
  }'

# فحص صحة الخادم
curl http://192.168.1.100:8080/api/health

# معلومات الجلسة
curl http://192.168.1.100:8080/api/session/session_test
```

---

## 📊 ملخص سريع

### Endpoints Summary

| Endpoint | Method | الوصف | المصادقة |
|----------|--------|-------|----------|
| `/api/attendance/check-in` | POST | تسجيل حضور | Hash Signature |
| `/api/health` | GET | فحص الصحة | لا |
| `/api/session/:id` | GET | تفاصيل الجلسة | لا |

### Status Codes Summary

| Code | Category | Action |
|------|----------|--------|
| 2xx | Success | عرض النتيجة |
| 4xx | Client Error | تصحيح البيانات وإعادة المحاولة |
| 5xx | Server Error | الانتظار وإعادة المحاولة |

---

## 📞 الدعم الفني

في حالة وجود مشاكل في الاتصال:

1. **تحقق من**: IP و Port صحيحين
2. **تحقق من**: كلا التطبيقين على نفس الشبكة
3. **تحقق من**: الخادم يعمل على تطبيق المندوب
4. **تواصل مع**: المسؤول عن النظام

---

<p align="center">
  <strong>📡 آخر تحديث: يناير 2024</strong>
</p>
