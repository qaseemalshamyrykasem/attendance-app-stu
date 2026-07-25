# 📥 دليل التثبيت - Attendance Student App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x+-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.2+-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Difficulty-متوسط-yellow?style=flat-square" alt="Difficulty" />
</p>

---

## 📋 جدول المحتويات

- [📖 نظرة عامة](#-نظرة-عامة)
- [🛠️ المتطلبات الأساسية](#️-المتطلبات-الأساسية)
- [🔧 إعداد بيئة التطوير](#-إعداد-بيئة-التطوير)
- [📦 خطوات التثبيت](#-خطوات-التثبيت)
- [⚙️ تشغيل Code Generation](#️-تشغيل-code-generation)
- [🚀 تشغيل التطبيق](#-تشغيل-التطبيق)
- 🏗️ [بناء للإنتاج](#️-بناء-للإنتاج)
- [🐛 حل المشاكل الشائعة](#-حل-المشاكل-الشائعة)
- [📱 أذونات التطبيق](#-أذونات-التطبيق)

---

## 📖 نظرة عامة

هذا الدليل يشرح خطوات تثبيت وتشغيل تطبيق **حضوري - Student App** على جهازك للتطوير أو الاستخدام الشخصي.

---

## 🛠️ المتطلبات الأساسية

### 1. Flutter SDK

```bash
# التحقق من تثبيت Flutter
flutter --version
```

**المطلوب:**
- **Flutter**: >= 3.16.0
- **Dart**: >= 3.2.0

#### تثبيت Flutter (إن لم يكن مثبتاً)

```bash
# macOS / Linux
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor

# Windows (باست PowerShell)
git clone https://github.com/flutter/flutter.git -b stable
$env:PATH += ";$PWD\flutter\bin"
flutter doctor
```

### 2. Android Studio (موصى به) أو VS Code

#### Android Studio

1. تحميل من: https://developer.android.com/studio
2. التثبيت مع:
   - Android SDK Command-line Tools
   - Android SDK Build-Tools
   - Android SDK Platform-Tools
   - Android Emulator (API 21+)

#### VS Code + Extensions

1. تحميل من: https://code.visualstudio.com/
2. تثبيت الإضافات:
   ```
   - Flutter
   - Dart
   ```

### 3. أدوات إضافية

| الأداة | الغرض | التثبيت |
|--------|-------|---------|
| **Git** | التحكم بالإصدارات | https://git-scm.com |
| **Java JDK** | بناء Android | >= 17 (مع Android Studio) |

---

## 🔧 إعداد بيئة التطوير

### تشغيل Flutter Doctor

```bash
flutter doctor
```

**المخرجات المتوقعة:**

```
[✓] Flutter (Channel stable, 3.x.x, ...)
[✓] Android toolchain - develop for Android devices
[✓] Chrome - develop for the web
[✓] Android Studio (version 202x.x)
[✓] VS Code (version 1.x.x)
[✓] Connected device (device name or emulator)
```

### إصلاح المشاكل الشائعة مع Flutter Doctor

```bash
# مشكلة رخصة Android
flutter doctor --android-licenses

# قبول جميع الرخص
yes | flutter doctor --android-licenses
```

---

## 📦 خطوات التثبيت

### الخطوة 1: استنساخ المشروع

```bash
# عبر HTTPS
git clone https://github.com/your-repo/Attendance_Student.git

# أو عبر SSH
git clone git@github.com:your-repo/Attendance_Student.git

# الدخول للمجلد
cd Attendance_Student
```

### الخطوة 2: مراجعة الفرع الصحيح

```bash
# عرض الفروع
git branch -a

# التبديل للفرع المطلوب (اختياري)
git checkout main
# أو
git checkout develop
```

### الخطوة 3: تثبيت التبعيات

```bash
flutter pub get
```

**المخرجات المتوقعة:**

```
Running "flutter pub get" in attendance_student...
Resolving dependencies...
+ _fe_analyzer_shared 67.0.0
+ analyzer 6.4.1
+ args 2.5.0
+ async 2.11.0
... (قائمة الحزم)
Changed 85 dependencies!
```

### الخطوة 4: التحقق من التبعيات

```bash
flutter pub deps
```

---

## ⚙️ تشغيل Code Generation

يستخدم المشروع Code Generation لإنشاء ملفات تلقائية.

### تثبيت build_runner

```bash
# تم تثبيته كـ dev_dependency
flutter pub run build_runner --version
```

### توليد الكود

```bash
# التوليد الأولي (مع حذف الملفات القديمة)
flutter pub run build_runner build --delete-conflicting-outputs

# التوليد العادي
flutter pub run build_runner build

# التوليد المستمر (أثناء التطوير)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### الملفات المُولَّدة

| الملف المصدر | الملف المُولَّد | الغرض |
|-------------|----------------|-------|
| `*_model.dart` | `*.freezed.dart` | Freezed classes |
| `*_model.dart` | `*.g.dart` | JSON serialization |
| `local_database.dart` | `local_database.g.dart` | Drift database code |
| `di_setup.dart` | `di_setup.g.dart` | Riverpod providers |

> ⚠️ **مهم**: إذا واجهت أخطاء في الـ import، تأكد من تشغيل build_runner أولاً.

---

## 🚀 تشغيل التطبيق

### على محاكي Android

```bash
# قائمة المحاكيات المتاحة
flutter emulators

# تشغيل محاكي
flutter emulators launch <emulator_name>

# تشغيل التطبيق
flutter run
```

### على جهاز حقيقي (USB)

```bash
# تفعيل USB Debugging على الجهاز
# Settings > About Phone > Build Number (اضغط 7 مرات)
# Developer Options > USB Debugging = ON

# عرض الأجهزة المتصلة
flutter devices

# تشغيل على الجهاز
flutter run -d <device_id>
```

### خيارات التشغيل المتقدمة

```bash
# وضع Debug
flutter run --debug

# وضع Profile
flutter run --profile

# وضع Release (للاختبار النهائي)
flutter run --release

# مع سجلات مفصلة
flutter run -v

# على متصفح Chrome
flutter run -d chrome
```

### خيارات التشغيل السريعة

```bash
# Hot Restart (R في Terminal)
# Hot Reload (r في Terminal)

# فصل التصحيح
flutter detach

# إنهاء التطبيق
flutter quit
```

---

## 🏗️ بناء للإنتاج

### بناء APK

```bash
# APK Debug (للاختبار)
flutter build apk --debug

# APK Release (للتوزيع)
flutter build apk --release

# APK بـ Architecture محدد
flutter build apk --release --target-platform android-arm64
flutter build apk --release --target-platform android-arm
```

**موقع APK بعد البناء:**
```
build/app/outputs/flutter-apk/app-debug.apk
build/app/outputs/flutter-apk/app-release.apk
```

### بناء App Bundle (Google Play)

```bash
flutter build appbundle --release
```

**موقع Bundle:**
```
build/app/outputs/bundle/release/app-release.aab
```

### توقيع APK يدوياً (اختياري)

```bash
# إنشاء مفتاح توقيع
keytool -genkey -v -keystore release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias release

# التوقيع أثناء البناء
flutter build appbundle --release \
  -- signing-key release-key.jks \
  -- keystore-password <password> \
  -- key-password <password>
```

### بناء iOS (من macOS فقط)

```bash
# يتطلب XCode و CocoaPods
cd ios
pod install
cd ..

# بناء
flutter build ios --release

# فتح في XCode
open ios/Runner.xcworkspace
```

---

## 🐛 حل المشاكل الشائعة

### ❌ مشكلة: Flutter not found

**الحل:**
```bash
# إضافة Flutter للـ PATH
export PATH="$PATH:/path/to/flutter/bin"

# أو إضافة لـ ~/.bashrc أو ~/.zshrc
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### ❌ مشكلة: Gradle build failed

**الحل:**
```bash
# تنظيف المشروع
flutter clean

# إعادة تثبيت التبعيات
flutter pub get

# إعادة البناء
flutter build apk --debug
```

### ❌ مشكلة: Code generation errors

**الحل:**
```bash
# حذف الملفات المُولَّدة وإعادة التوليد
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### ❌ مشكلة: SDK version mismatch

**الحل:**
```bash
# تحديث Flutter
flutter upgrade

# تحديث التبعيات
flutter pub upgrade
```

### ❌ مشكلة: License not accepted

**الحل:**
```bash
flutter doctor --android-licenses
yes | flutter doctor --android-licenses
```

### ❌ مشكلة: Port already in use

**الحل:**
```bash
# البحث عن العملية التي تستخدم المنفذ
lsof -i :8080

# قتل العملية
kill -9 <PID>

# أو استخدام منفذ آخر
flutter run --dart-define=PORT=9090
```

### ❌ مشكلة: Dependency conflict

**الحل:**
```bash
# تحديث pubspec.lock
flutter pub upgrade --major-versions

# أو حل التعارضات يدوياً
flutter pub deps
```

### ❌ مشكلة: Missing fonts or assets

**الحل:**
```bash
# التأكد من وجود مجلد assets
ls -la assets/

# إنشاء المجلدات المفقودة
mkdir -p assets/images assets/icons assets/animations assets/fonts

# تنظيف وإعادة البناء
flutter clean && flutter pub get && flutter run
```

### ❌ مشكلة: AndroidX migration

**الحل:**
```bash
# ترقية إلى AndroidX
flutter pub add --sdk flutter androidX
```

---

## 📱 أذونات التطبيق

### أذونات Android

أضف في `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- أذونات الكاميرا لمسح QR -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- أذونات الشبكة للاتصال بالخادم -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />

<!-- أذونات الإشعارات -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<!-- أذونات تخزين الصور -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" 
    android:maxSdkVersion="32" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" 
    android:maxSdkVersion="28" />

<!-- ميزة الكاميرا (مطلوبة للتطبيق) -->
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
```

### أذونات iOS

أضف في `ios/Runner/Info.plist`:

```xml
<!-- وصف استخدام الكاميرا -->
<key>NSCameraUsageDescription</key>
<string>يحتاج التطبيق للكاميرا لمسح رموز QR Code لتسجيل الحضور</string>

<!-- وصف استخدام الشبكة -->
<key>NSLocalNetworkUsageDescription</key>
<string>يحتاج التطبيق للاتصال بشبكة WiFi المحلية للتواصل مع خادم الحضور</string>

<!-- وصف الإشعارات -->
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### طلب الأذونات في الكود

```dart
// طلب إذن الكاميرا
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    status = await Permission.camera.request();
  }
  return status.isGranted;
}
```

---

## ✅ قائمة التحقق قبل التشغيل

قبل تشغيل التطبيق لأول مرة، تأكد من:

- [ ] Flutter SDK >= 3.16.0 مثبت
- [ ] Dart SDK >= 3.2.0 مثبت
- [ ] Android Studio أو VS Code مثبت
- [ ] Android SDK مثبت ومحدث
- [ ] `flutter doctor` بدون أخطاء حرجة
- [ ] المشروع مستنسخ بنجاح
- [ ] `flutter pub get` نفذ بنجاح
- [ ] `build_runner build` نفذ بنجاح
- [ ] المحاكي يعمل أو الجهاز متصل
- [ ] ملفات الخطوط موجودة في `assets/fonts/`
- [ ] مجلدات Assets موجودة (`images`, `icons`, `animations`)

---

## 🔄 التحديث من إصدار سابق

```bash
# سحب آخر التحديثات
git pull origin main

# تحديث التبعيات
flutter pub get

# إعادة توليد الكود
flutter pub run build_runner build --delete-conflicting-outputs

# تنظيف وإعادة بناء
flutter clean && flutter run
```

---

## 📞 المساعدة

إذا واجهت مشكلة غير مذكورة هنا:

1. راجع [Flutter Documentation](https://docs.flutter.dev/)
2. افتح Issue على GitHub: [Issues](https://github.com/your-repo/issues)
4. تواصل عبر: support@attendance-app.com

---

<p align="center">
  <strong>🎉 تم إعداد التطبيق بنجاح!</strong>
</p>
