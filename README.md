# 📱 حضوري - Offline Attendance System (Student App)

<p align="center">
  <img src="assets/images/app_icon.png" alt="حضوري App Icon" width="150" height="150" />
</p>

<p align="center">
  <strong>تطبيق الطالب لنظام الحضور الذكي بدون إنترنت</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x+-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.2+-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-9E9E9E?style=flat-square" alt="Platform" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License" />
  <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square" alt="Version" />
</p>

---

## 📋 جدول المحتويات

- [📖 نظرة عامة](#-نظرة-عامة)
- [✨ الميزات الرئيسية](#-الميزات-الرئيسية)
- [🛠️ المتطلبات الأساسية](#️-المتطلبات-الأساسية)
- [🚀 التثبيت والتشغيل](#-التثبيت-والتشغيل)
- [📁 هيكل المشروع](#-هيكل-المشروع)
- [🎨 التقنيات المستخدمة](#-التقنيات-المستخدمة)
- [📱 الشاشات والميزات](#-الشاشات-والميزات)
- [🔗 الاتصال بتطبيق المندوب](#-الاتصال-بتطبيق-المندوب)
- [📄 الرخصة](#-الرخصة)

---

## 📖 نظرة عامة

**حضوري** هو تطبيق طالب متكامل لنظام الحضور الذكي الذي يعمل **بدون الحاجة لإنترنت**. يتيح للطلاب تسجيل حضورهم عبر مسح QR Code أو الاتصال اليدوي بخادم المندوب على نفس الشبكة المحلية.

### 🎯 الأهداف الرئيسية

- ✅ تسجيل حضور سريع وآمن
- ✅ عمل بدون إنترنت (Offline-first)
- ✅ حفظ البيانات محلياً
- ✅ اتصال آمن عبر الشبكة المحلية
- ✅ واجهة عربية سهلة الاستخدام

---

## ✨ الميزات الرئيسية

| الميزة | الوصف |
|--------|-------|
| 🔍 مسح QR Code | مسح سريع لكود QR من تطبيق المندوب |
| 🔌 اتصال يدوي | إدخال عنوان IP ورقم المنفذ يدوياً |
| 👤 ملف شخصي | إدارة بيانات الطالب الشخصية |
| 📊 سجل الحضور | عرض وتصفح سجل الحضور الكامل |
| ⚙️ إعدادات مرنة | تخصيص الإشعارات والمظهر |
| 🔒 تشفير آمن | تشفير البيانات قبل الإرسال |
| 💾 تخزين محلي | حفظ جميع البيانات محلياً |

---

## 🛠️ المتطلبات الأساسية

### البرامج المطلوبة

| البرنامج | الإصدار | الغرض |
|----------|---------|-------|
| **Flutter SDK** | >= 3.16.0 | إطار العمل الأساسي |
| **Dart SDK** | >= 3.2.0 | لغة البرمجة |
| **Android Studio** | الأخير | التطوير والتشغيل |
| **أو VS Code** | مع Flutter Extension | بديل للتطوير |

### المتطلبات النظامية

- **Android**: API 21+ (Android 5.0 Lollipop)
- **iOS**: iOS 12.0+
- **الكاميرا**: مطلوبة لمسح QR Code
- **الشبكة**: Wi-Fi للاتصال بالخادم المحلي

---

## 🚀 التثبيت والتشغيل

### 1. استنساخ المشروع

```bash
git clone https://github.com/your-repo/Attendance_Student.git
cd Attendance_Student
```

### 2. تثبيت التبعيات

```bash
flutter pub get
```

### 3. تشغيل Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. تشغيل التطبيق

```bash
# للأجهزة المتصلة
flutter run

# أو للمحاكي
flutter run -d emulator
```

### 5. بناء APK للإنتاج

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (Google Play)
flutter build appbundle --release
```

> 📌 **ملاحظة**: للحصول على تعليمات تفصيلية، راجع ملف [INSTALL.md](INSTALL.md)

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                          # نقطة الدخول الرئيسية
├── app.dart                           # إعداد التطبيق
│
├── core/                              # الطبقة الأساسية
│   ├── constants/
│   │   └── app_constants.dart         # الثوابت والرسائل
│   ├── router/
│   │   └── app_router.dart            # إعداد التنقل (Go Router)
│   ├── theme/
│   │   └── app_colors.dart           # ألوان التطبيق
│   ├── di/
│   │   └── di_setup.dart             # حقن التبعيات (Riverpod)
│   └── utils/
│       ├── crypto_utils.dart          # أدوات التشفير
│       └── helpers.dart              # دوال مساعدة
│
├── data/                              # طبقة البيانات
│   ├── models/                        # نماذج البيانات
│   │   ├── student_model.dart
│   │   ├── attendance_model.dart
│   │   ├── settings_model.dart
│   │   ├── connection_log_model.dart
│   │   └── server_response.dart
│   ├── data_sources/
│   │   └── local/
│   │       ├── local_database.dart    # قاعدة البيانات (Drift/SQLite)
│   │       ├── hive_service.dart     # خدمة التخزين المؤقت
│   │       └── shared_prefs_service.dart
│   └── repositories/                  # تنفيذ المخازن
│       ├── attendance_repository_impl.dart
│       ├── student_repository_impl.dart
│       └── settings_repository_impl.dart
│
├── domain/                            # طبقة المنطق (Domain)
│   ├── entities/                      # الكيانات
│   │   ├── student_entity.dart
│   │   └── attendance_entity.dart
│   ├── repositories/                  # واجهات المخازن
│   │   ├── attendance_repository.dart
│   │   ├── student_repository.dart
│   │   └── settings_repository.dart
│   └── use_cases/                     # حالات الاستخدام
│       ├── attendance_use_case.dart
│       ├── student_use_case.dart
│       └── settings_use_case.dart
│
├── presentation/                      # طبقة العرض
│   └── screens/                       # شاشات التطبيق
│       ├── main_shell.dart            # الهيكل الرئيسي
│       ├── splash_screen.dart         # شاشة البداية
│       ├── setup_screen.dart          # شاشة الإعداد الأولي
│       ├── home_screen.dart           # الشاشة الرئيسية
│       ├── scan_qr_screen.dart        # شاشة مسح QR
│       ├── manual_connect_screen.dart # شاشة الاتصال اليدوي
│       ├── attendance_status_screen.dart
│       ├── profile_screen.dart        # الملف الشخصي
│       ├── history_screen.dart        # سجل الحضور
│       ├── settings_screen.dart       # الإعدادات
│       └── about_screen.dart          # حول التطبيق
│
└── services/                          # الخدمات الخارجية
    ├── network/
    │   └── http_client.dart           # عميل HTTP
    └── notification/
        └── notification_service.dart  # خدمة الإشعارات

assets/
├── images/                            # الصور والأيقونات
├── icons/                             # أيقونات SVG
├── animations/                        # الرسوم المتحركة
└── fonts/                             # الخطوط (Cairo)
```

---

## 🎨 التقنيات المستخدمة

### إطار العمل الأساسي

| التقنية | الاستخدام |
|---------|-----------|
| **Flutter** | إطار عمل UI عبر المنصات |
| **Dart** | لغة البرمجة |

### إدارة الحالة والتنقل

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Riverpod** | ^2.5.1 | إدارة الحالة وحقن التبعيات |
| **Go Router** | ^14.2.0 | التنقل وإدارة المسارات |

### قاعدة البيانات والتخزين

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Drift** | ^2.15.0 | قاعدة بيانات SQLite (Type-safe) |
| **Hive** | ^2.2.3 | التخزين المؤقت السريع |
| **SharedPreferences** | ^2.2.3 | حفظ الإعدادات البسيطة |

### الشبكة والاتصال

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Dio** | ^5.4.1 | عميل HTTP |
| **Connectivity Plus** | ^6.0.3 | فحص حالة الشبكة |
| **Network Info Plus** | ^5.0.2 | معلومات الشبكة |

### الميزات الخاصة

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Mobile Scanner** | ^5.1.1 | مسح QR Code |
| **Permission Handler** | ^11.3.1 | إدارة الأذونات |
| **Freezed** | ^2.5.2 | إنشاء Models غير قابلة للتغيير |
| **JSON Serializable** | ^6.7.1 | تسلسل JSON |
| **Logger** | ^2.0.2+1 | تسجيل السجلات |
| **Crypto** | ^3.0.3 | عمليات التشفير |
| **Flutter Local Notifications** | ^17.2.3 | الإشعارات المحلية |

### واجهة المستخدم

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Flutter SVG** | ^2.0.10+1 | دعم SVG |
| **Shimmer** | ^3.0.0 | تأثير التحميل |
| **Flutter Animate** | ^4.5.0 | الرسوم المتحركة |
| **Cairo Font** | - | الخط العربي |

---

## 📱 الشاشات والميزات

### 🗺️ خريطة الشاشات

```
┌─────────────────────────────────────────────────────────────┐
│                    SplashScreen (البداية)                    │
│                     تحميل + فحص الإعداد                       │
└─────────────────────┬───────────────────────────────────────┘
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
┌──────────────────┐  ┌──────────────────────────────────────┐
│ SetupScreen      │  │           MainShell                   │
│ (الإعداد الأولي)  │  │  ┌────────────────────────────────┐  │
│                  │  │  │    Bottom Navigation Bar        │  │
│ • إدخال الاسم    │  │  ├────────────────────────────────┤  │
│ • الرقم الجامعي  │  │  │  🏠 الرئيسية  📋 الحضور  👤 أنا  │  │
│ • القسم/المستوى  │  │  ├────────────────────────────────┤  │
│ • الشعبة         │  │  │                                │  │
└──────────────────┘  │  │     [الشاشة النشطة]             │  │
                       │  │                                │  │
                       │  └────────────────────────────────┘  │
                       └──────────────────────────────────────┘
```

### 📱 تفاصيل الشاشات

#### 1. SplashScreen (شاشة البداية)
- عرض شعار التطبيق مع تأثير حركي
- فحص إكمال الإعداد الأولي
- توجيه المستخدم للشاشة المناسبة

#### 2. SetupScreen (شاشة الإعداد)
- نموذج إدخال بيانات الطالب:
  - الاسم الكامل
  - الرقم الجامعي
  - القسم الدراسي
  - المستوى الدراسي
  - الشعبة
  - رقم الهاتف (اختياري)
  - الصورة الشخصية (اختياري)

#### 3. HomeScreen (الشاشة الرئيسية)
- **زر مسح QR Code**: فتح الكاميرا للمسح
- **زر الاتصال اليدوي**: إدخال IP و Port
- حالة آخر اتصال
- إحصائيات سريعة

#### 4. ScanQrScreen (مسح QR Code)
- واجهة الكاميرا لمسح QR
- دعم تنسيقات متعددة:
  - `attendance://ip:port/sessionId`
  - `{"ip":"...","port":...,"sessionId":"..."}`
  - `ip:port:sessionId`
- تأكيد البيانات قبل الإرسال

#### 5. ManualConnectScreen (الاتصال اليدوي)
- حقول إدخال IP و Port
- اختيار Session ID (إن وجد)
- التحقق من صحة البيانات
- حالة الاتصال المباشر

#### 6. AttendanceStatusScreen (حالة الحضور)
- عرض نتيجة عملية الحضور
- رسائل النجاح/الفشل
- خيارات إعادة المحاولة

#### 7. ProfileScreen (الملف الشخصي)
- عرض بيانات الطالب
- تعديل البيانات
- حذف الحساب

#### 8. HistoryScreen (سجل الحضور)
- قائمة سجلات الحضور
- فلترة حسب التاريخ والحالة
- تفاصيل كل سجل
- تصدير البيانات

#### 9. SettingsScreen (الإعدادات)
- تفعيل/تعطيل الإشعارات
- وضع العرض (فاتح/داكن)
- مسح البيانات
- حول التطبيق

#### 10. AboutScreen (حول التطبيق)
- معلومات الإصدار
- روابط التواصل
- تراخيص المصادر المفتوحة

---

## 🔗 الاتصال بتطبيق المندوب

### 🔄 كيف يعمل الاتصال

```
┌─────────────────┐         ┌─────────────────┐
│   تطبيق المندوب  │◄──────►│   تطبيق الطالب   │
│   (Admin App)   │  WiFi   │  (Student App)  │
│                 │  Local  │                 │
│  • يعرض QR Code │ Network│  • يمسح QR Code │
│  • يستقبل البيانات│        │  • يرسل الحضور  │
│  • يسجل الحضور  │         │  • يستلم التأكيد│
└─────────────────┘         └─────────────────┘
```

### 📡 خطوات الاتصال

1. **تشغيل تطبيق المندوب**
   - افتح تطبيق Admin على جهاز آخر
   - تأكد من تشغيل الخادم المحلي
   - اعرض QR Code للجلسة

2. **الاتصال من تطبيق الطالب**

   **الطريقة الأولى: مسح QR Code**
   ```
   1. اضغط على "مسح QR Code"
   2. وجه الكاميرا نحو QR Code
   3. انتظر قراءة البيانات
   4. أكد بيانات الحضور
   5. انتظر التأكيد
   ```

   **الطريقة الثانية: الاتصال اليدوي**
   ```
   1. اضغط على "اتصال يدوي"
   2. أدخل IP الخادم (مثال: 192.168.1.100)
   3. أدخل رقم المنفذ (افتراضي: 8080)
   4. أدخل Session ID (إن وجد)
   5. اضغط "اتصال"
   ```

### ⚙️ إعدادات الاتصال الافتراضية

| الإعداد | القيمة | الوصف |
|---------|--------|-------|
| **المنفذ الافتراضي** | 8080 | رقم منفذ الخادم |
| **مهلة الاتصال** | 10 ثواني | وقت الانتظار للاتصال |
| **مهلة الاستقبال** | 15 ثانية | وقت الانتظار للاستجابة |
| **البروتوكول** | HTTP | بروتوكول الاتصال |

### 🔒 أمان الاتصال

- تشفير البيانات قبل الإرسال (SHA-256 Hash)
- التحقق من صحة البيانات
- تسجيل جميع محاولات الاتصال
- حماية من التكرار (Duplicate Check)

> 📌 **ملاحظة**: للحصول على توثيق API كامل، راجع ملف [API.md](API.md)

---

## 📄 الرخصة

هذا المشروع مرخص تحت رخصة **MIT License**.

```
MIT License

Copyright (c) 2024 Attendance System Project

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 📚 الوثائق الإضافية

| الملف | الوصف |
|-------|-------|
| [INSTALL.md](INSTALL.md) | تعليمات التثبيت التفصيلية |
| [API.md](API.md) | توثيق التعامل مع API |
| [DATABASE.md](DATABASE.md) | توثيق قاعدة البيانات المحلية |
| [ARCHITECTURE.md](ARCHITECTURE.md) | شرح العمارة والتصميم |
| [CHANGELOG.md](CHANGELOG.md) | سجل التغييرات والإصدارات |

---

## 🤝 المساهمة

نرحب بمساهماتكم! يرجى:

1. Fork المشروع
2. إنشاء فرع جديد (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push الفرع (`git push origin feature/AmazingFeature`)
5. فتح Pull Request

---

## 📞 الدعم والتواصل

- 📧 **البريد الإلكتروني**: support@attendance-app.com
- 🐛 **بلاغ عن مشكلة**: [GitHub Issues](https://github.com/your-repo/issues)
- 💬 **المناقشات**: [GitHub Discussions](https://github.com/your-repo/discussions)

---

<p align="center">
  Made with ❤️ for Education
</p>
