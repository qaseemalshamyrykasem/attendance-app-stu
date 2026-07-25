# 📝 سجل التغييرات - Changelog

<p align="center">
  <img src="https://img.shields.io/badge/Keep_a_Changelog-v1.1.0-05F140?style=flat-square" alt="Changelog" />
  <img src="https://img.shields.io/badge/SemVer-1.0.0-blue?style=flat-square" alt="SemVer" />
</p>

جميع التغييرات الملحوظة لهذا المشروع ستُوثق في هذا الملف.

يتبع هذا الملف معيار [Keep a Changelog](https://keepachangelog.com/) وإصدار [Semantic Versioning](https://semver.org/lang/ar/).

---

## [1.0.0] - 2024-01-15

### 🎉 الإصدار الأولي - Initial Release

#### ✨ الميزات الجديدة (Features)

**📱 الشاشات الأساسية**
- `SplashScreen` - شاشة البداية مع تأثيرات حركية
- `SetupScreen` - شاشة إعداد الملف الشخصي الأولي
- `HomeScreen` - الشاشة الرئيسية مع لوحة التحكم
- `ScanQrScreen` - مسح QR Code عبر الكاميرا
- `ManualConnectScreen` - الاتصال اليدوي بإدخال IP و Port
- `AttendanceStatusScreen` - عرض نتيجة تسجيل الحضور
- `ProfileScreen` - عرض وتعديل الملف الشخصي
- `HistoryScreen` - سجل الحضور الكامل مع الفلترة
- `SettingsScreen` - إعدادات التطبيق
- `AboutScreen` - معلومات حول التطبيق

**🔐 الأمان والمصادقة**
- تشفير SHA-256 لبيانات الحضور قبل الإرسال
- التحقق من سلامة البيانات (Data Integrity)
- حماية من التكرار (Duplicate Check)
- تسجيل جميع محاولات الاتصال

**💾 قاعدة البيانات المحلية**
- قاعدة بيانات SQLite عبر Drift ORM
- 4 جداول: `student_profile`, `attendance_history`, `settings`, `connection_logs`
- عمليات CRUD كاملة
- دعم Transactions للعمليات الذرية
- تنظيف تلقائي للسجلات القديمة

**🌐 الاتصال بالخادم**
- عميل HTTP مخصص للاتصال بالخادم المحلي
- دعم مهلات الاتصال القابلة للتكوين
- فحص صحة الخادم (Health Check)
- الحصول على معلومات الجلسة
- معالجة شاملة لأخطاء الشبكة

**📡 مسح QR Code**
- دعم مسح QR Code عبر الكاميرا
- تحليل تنسيقات متعددة:
  - URI Format: `attendance://ip:port/sessionId`
  - JSON Format: `{"ip":"...","port":...,"sessionId":"..."}`
  - Simple Format: `ip:port:sessionId`
- تأكيد البيانات قبل الإرسال

**🎨 واجهة المستخدم**
- تصميم عربي بالكامل (RTL)
- خط Cairo العربي
- وضع فاتح/داكن (Dark Mode)
- رسوم متحركة سلسة (Flutter Animate)
- تأثيرات Loading (Shimmer)
- أيقونات SVG

**🔔 الإشعارات**
- إشعارات محلية لتأكيد الحضور
- تخصيص تفعيل/تعطيل الإشعارات
- دعم Timezone

**⚙️ إدارة الحالة**
- Riverpod لإدارة الحالة
- Dependency Injection كاملة
- State Notifiers للمكونات التفاعلية
- Future/Stream Providers للبيانات غير المتزامنة

**🧭 التنقل**
- Go Router للتنقل التصريحي
- Deep Linking support
- Nested Navigation (Tabs + Sub-routes)
- Type-safe parameter passing
- Error page handling

**🏗️ العمارة**
- Clean Architecture (3 Layers + Core)
- MVVM Pattern
- Repository Pattern
- Use Cases (Domain Logic)
- Entities vs Models separation
- Code Generation (Freezed, JSON Serializable, Riverpod Generator)

#### 📦 الحزم والتقنيات (Tech Stack)

| الحزمة | الإصدار | الاستخدام |
|--------|---------|-----------|
| flutter | >=3.16.0 | إطار العمل |
| dart | >=3.2.0 | لغة البرمجة |
| flutter_riverpod | ^2.5.1 | إدارة الحالة |
| go_router | ^14.2.0 | التنقل |
| drift | ^2.15.0 | قاعدة البيانات |
| hive | ^2.2.3 | تخزين مؤقت |
| dio | ^5.4.1 | HTTP Client |
| mobile_scanner | ^5.1.1 | مسح QR |
| freezed | ^2.5.2 | Models غير قابلة للتغيير |
| json_serializable | ^6.7.1 | JSON Serialization |
| permission_handler | ^11.3.1 | إدارة الأذونات |
| flutter_local_notifications | ^17.2.3 | الإشعارات |

#### 📁 هيكل المشروع

```
lib/
├── main.dart, app.dart           # نقطة الدخول
├── core/                         # الطبقة الأساسية
│   ├── constants/                # الثوابت والرسائل
│   ├── di/                       # حقن التبعيات
│   ├── router/                   # التنقل
│   ├── theme/                    # الثيمات
│   └── utils/                    # الأدوات المساعدة
├── domain/                       # طبقة المنطق
│   ├── entities/                 # الكيانات
│   ├── repositories/             # واجهات المخازن
│   └── use_cases/                # حالات الاستخدام
├── data/                         # طبقة البيانات
│   ├── models/                   # نماذج البيانات
│   ├── data_sources/             # مصادر البيانات
│   └── repositories/             # تنفيذ المخازن
├── presentation/                 # طبقة العرض
│   └── screens/                  # الشاشات
└── services/                     # الخدمات الخارجية
```

#### 📊 الجداول وقاعدة البيانات

| الجدول | الوصف | عدد الأعمدة |
|--------|-------|------------|
| `student_profile` | بيانات الطالب | 12 |
| `attendance_history` | سجل الحضور | 10 |
| `settings` | إعدادات التطبيق | 4 |
| `connection_logs` | سجل الاتصالات | 6 |

#### 🔌 نقاط نهاية API المدعومة

| Endpoint | Method | الوصف |
|----------|--------|-------|
| `/api/attendance/check-in` | POST | تسجيل حضور جديد |
| `/api/health` | GET | فحص صحة الخادم |
| `/api/session/:id` | GET | معلومات جلسة محددة |

#### 🌍 الدعم اللغوي

- ✅ **العربية** (اللغة الافتراضية) - RTL Layout
- 🔄 **English** - جاهز للإضافة مستقبلاً

#### 📱 المنصات المدعومة

- ✅ Android (API 21+)
- ✅ iOS (12.0+)

---

## [Unreleased]

### 🚧 قيد التطوير

#### الميزات المخططة
- [ ] دعم اللغة الإنجليزية (i18n)
- [ ] مزامنة متعددة الأجهزة
- [ ] تصدير سجل الحضور (PDF/Excel)
- [ ] إحصائيات تفصيلية مع رسم بياني
- [ ] وضع Offline كامل مع Queue
- [ ] دعم Bluetooth للاتصال
- [ ] Widget للشاشة الرئيسية
- [ ] Face ID/Fingerprint للمصادقة
- [ ] Web App (Flutter Web)
- [ ] Desktop App (Windows/macOS/Linux)

#### تحسينات مخططة
- [ ] تحسين أداء قاعدة البيانات الكبيرة
- [ ] إضافة Unit Tests شاملة
- [ ] Integration Tests
- [ ] Widget Tests
- [ ] CI/CD Pipeline
- [ ] تحليل覆盖率 (Code Coverage)
- [ ] Performance Profiling

---

## 📅 تاريخ النسخ

### تنسيق الإصدارات

هذا المشروع يتبع [Semantic Versioning 2.0.0](https://semver.org/lang/ar/):

```
MAJOR.MINOR.PATCH

MAJOR: تغييرات غير متوافقة مع الإصدارات السابقة
MINOR: ميزات جديدة متوافقة مع الإصدارات السابقة
PATCH: تصحيحات أخطاء متوافقة
```

### أنواع التغييرات

| الرمز | المعنى |
|------|--------|
| `✨ Added` | ميزات جديدة |
| `🔄 Changed` | تغييرات في ميزات موجودة |
| `🐛 Fixed` | تصحيح أخطاء |
| `🗑️ Removed` | ميزات/mحتى محذوف |
| `🔒 Security` | تصحيحات أمنية |
| `📖 Deprecated` | ميزات سيتم إزالتها |

---

## 🤝 المساهمة في Changelog

عند إضافة تغييرات جديدة، يرجى:

1. إضافة قسم تحت `[Unreleased]`
2. استخدام التصنيفات الصحيحة
3. كتابة وصف واضح ومختصر
4. ذكر Issues المرتبطة إن وجدت
5. عند الإصدار، نقل التغييرات لقسم الإصدار الجديد

### مثال:

```markdown
## [Unreleased]

### Added
- `[#123]` إضافة ميزة جديدة (#123)

### Fixed
- `[#456]` إصلاح مشكلة في الاتصال (#456)
```

---

## 📞 الإبلاغ عن مشاكل

في حالة وجود أي مشاكل أو اقتراحات:

- 📧 **البريد**: support@attendance-app.com
- 🐛 **Issues**: [GitHub Issues](https://github.com/your-repo/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/your-repo/discussions)

---

## 📄 الرخصة

هذا المشروع مرخص تحت رخصة **MIT License** - راجع ملف [LICENSE](LICENSE) للتفاصيل.

---

<p align="center">
  <strong>📝 آخر تحديث: يناير 2024</strong>
</p>

<p align="center">
  Made with ❤️ using <a href="https://keepachangelog.com/">Keep a Changelog</a>
</p>
