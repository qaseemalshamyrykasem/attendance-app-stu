# 🏗️ توثيق العمارة - Architecture Documentation

<p align="center">
  <img src="https://img.shields.io/badge/Architecture-Clean_Architecture-6C757D?style=flat-square" alt="Clean Architecture" />
  <img src="https://img.shields.io/badge/Pattern-MVVM-0D6EFD?style=flat-square" alt="MVVM" />
  <img src="https://img.shields.io/badge/State-Riverpod-42A5F5?style=flat-square" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Router-Go_Router-28A745?style=flat-square" alt="Go Router" />
</p>

---

## 📋 جدول المحتويات

- [📖 نظرة عامة](#-نظرة-عامة)
- [🎯 المبادئ الأساسية](#-المبادئ-الأساسية)
- [📐 Clean Architecture](#-clean-architecture)
  - [طبقة Presentation](#--طبقة-presentation)
  - [طبقة Domain](#--طبقة-domain)
  - [طبقة Data](#--طبقة-data)
  - [طبقة Core](#--طبقة-core)
- [🔄 MVVM Pattern](#-mvvm-pattern)
- [💉 Riverpod لإدارة الحالة](#-riverpod-لإدارة-الحالة)
- [🧭 Go Router للتنقل](#-go-router-للتنقل)
- [📊 رسم توضيحي للعمارة](#-رسم-توضيحي-للعمارة)
- [🔀 سير البيانات](#-سير-البيانات)
- [📁 هيكل الملفات التفصيلي](#-هيكل-الملفات-التفصيلي)

---

## 📖 نظرة عامة

يتبع تطبيق **حضوري** نمط **Clean Architecture** مع **MVVM Pattern** لتحقيق:

- **فصل المسؤوليات**: كل طبقة لها دور محدد
- **قابلية الاختبار**: سهولة كتابة Unit Tests
- **صيانة سهلة**: تعديل جزء دون تأثير على الآخر
- **قابلية التوسع**: إضافة ميزات جديدة بسهولة

---

## 🎯 المبادئ الأساسية

### 📜 مبادئ SOLID

| المبدأ | التطبيق في المشروع |
|--------|-------------------|
| **S** - Single Responsibility | كل class له مسؤولية واحدة |
| **O** - Open/Closed | فتح للإغلاق، مغلق للتعديل (Use Cases) |
| **L** - Liskov Substitution | Entities قابلة للاستبدال |
| **I** - Interface Segregation | واجهات صغيرة ومحددة |
| **D** - Dependency Inversion | الاعتماد على Abstractions |

### 🔁 Dependency Rule

```
┌─────────────────────────────────────────────┐
│              PRESENTATION                   │  ← يمكنه رؤية Domain
│         (Screens, ViewModels)               │
└──────────────────────┬──────────────────────┘
                       │ يعتمد على
                       ▼
┌─────────────────────────────────────────────┐
│                 DOMAIN                      │  ← مستقل تماماً
│      (Entities, UseCases, Repositories)     │
└──────────────────────┬──────────────────────┘
                       │ يعتمد على
                       ▼
┌─────────────────────────────────────────────┐
│                  DATA                       │  ← ينفذ Domain
│    (Repositories Impl, Models, DataSources) │
└─────────────────────────────────────────────┘

⚠️ القاعدة: لا يمكن للطبقات الداخلية معرفة الطبقات الخارجية
```

---

## 📐 Clean Architecture

### 📊 نظرة عامة على الطبقات

```
┌─────────────────────────────────────────────────────────────────┐
│                           CORE                                  │
│              (Constants, Utils, Router, DI, Theme)             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │  PRESENTATION   │  │     DOMAIN      │  │      DATA       │ │
│  │                 │  │                 │  │                 │ │
│  │ • Screens       │  │ • Entities      │  │ • Models        │ │
│  │ • Widgets       │  │ • Use Cases     │  │ • Repositories  │ │
│  │ • ViewModels    │  │ • Repositories  │  │ • Data Sources  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🖥️ طبقة `Presentation`

**المسؤولية:** عرض البيانات والتفاعل مع المستخدم

#### الهيكل

```
lib/presentation/
└── screens/
    ├── main_shell.dart           # الهيكل الرئيسي (Shell)
    ├── splash_screen.dart        # شاشة البداية
    ├── setup_screen.dart         # شاشة الإعداد الأولي
    ├── home_screen.dart          # الشاشة الرئيسية
    ├── scan_qr_screen.dart       # مسح QR Code
    ├── manual_connect_screen.dart # الاتصال اليدوي
    ├── attendance_status_screen.dart # نتيجة الحضور
    ├── profile_screen.dart       # الملف الشخصي
    ├── history_screen.dart       # سجل الحضور
    ├── settings_screen.dart      # الإعدادات
    └── about_screen.dart         # حول التطبيق
```

#### المكونات الرئيسية

| المكون | الوصف |
|--------|-------|
| **Screens** | صفحات كاملة (Stateful/Stateless Widgets) |
| **Widgets** | مكونات UI قابلة لإعادة الاستخدام |
| **Providers** | Riverpod Providers لحالة الشاشة |

#### مثال: Screen بسيط

```dart
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // قراءة من Provider
    final studentAsync = ref.watch(studentProvider);
    
    return Scaffold(
      body: studentAsync.when(
        data: (student) => _buildContent(context, student),
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorWidget(error: e),
      ),
    );
  }
}
```

---

### 🧠 طبقة `Domain`

**المسؤولية:** منطق العمل الخالص (Business Logic)

> ⚠️ هذه الطبقة **مستقلة** تماماً عن أي framework أو مكتبة خارجية

#### الهيكل

```
lib/domain/
├── entities/
│   ├── student_entity.dart      # كيان الطالب
│   └── attendance_entity.dart   # كيان الحضور
├── repositories/
│   ├── student_repository.dart  # واجهة مخزن الطالب
│   ├── attendance_repository.dart # واجهة مخزن الحضور
│   └── settings_repository.dart # واجهة مخزن الإعدادات
└── use_cases/
    ├── student_use_case.dart    # حالات استخدام الطالب
    ├── attendance_use_case.dart # حالات استخدام الحضور
    └── settings_use_case.dart   # حالات استخدام الإعدادات
```

#### Entities (الكيانات)

```dart
/// كيان الطالب - يمثل بيانات الطالب الأساسية
class StudentEntity {
  final String id;
  final String name;
  final String studentId;
  final String department;
  final String level;
  final String section;
  
  const StudentEntity({
    required this.id,
    required this.name,
    required this.studentId,
    required this.department,
    required this.level,
    required this.section,
  });
}
```

#### Repositories Interfaces (واجهات المخازن)

```dart
/// واجهة مجردة لمخزن بيانات الحضور
abstract class AttendanceRepository {
  /// إرسال بيانات الحضور
  Future<AttendanceEntity> submitAttendance({
    required String ip,
    required int port,
    required String sessionId,
    required Map<String, dynamic> studentData,
  });

  /// الحصول على سجل الحضور
  Future<List<AttendanceEntity>> getAttendanceHistory({
    int? limit,
    int? offset,
  });
}
```

#### Use Cases (حالات الاستخدام)

```dart
/// حالة الاستخدام: تسجيل حضور جديد
class SubmitAttendanceUseCase {
  final AttendanceRepository _repository;

  SubmitAttendanceUseCase(this._repository);

  /// تنفيذ عملية تسجيل الحضور
  Future<Result<AttendanceEntity>> call(AttendanceParams params) async {
    try {
      // 1. التحقق من صحة البيانات
      if (!params.isValid) {
        return Result.error('بيانات غير صحيحة');
      }
      
      // 2. تنفيذ العملية عبر Repository
      final result = await _repository.submitAttendance(
        ip: params.ip,
        port: params.port,
        sessionId: params.sessionId,
        studentData: params.toMap(),
      );
      
      return Result.success(result);
    } on NetworkException catch (_) {
      return Result.error('خطأ في الاتصال');
    }
  }
}
```

---

### 💾 طبقة `Data`

**المسؤولية:** التعامل مع مصادر البيانات وتنفيذ واجهات Domain

#### الهيكل

```
lib/data/
├── models/                          # نماذج البيانات (Data Transfer Objects)
│   ├── student_model.dart
│   ├── attendance_model.dart
│   ├── settings_model.dart
│   ├── connection_log_model.dart
│   └── server_response.dart
├── data_sources/
│   └── local/
│       ├── local_database.dart      # Drift/SQLite
│       ├── hive_service.dart        # Hive Cache
│       └── shared_prefs_service.dart # SharedPreferences
└── repositories/                    # تنفيذ واجهات Domain
    ├── attendance_repository_impl.dart
    ├── student_repository_impl.dart
    └── settings_repository_impl.dart
```

#### Models vs Entities

```dart
// ===== Domain Layer (Entity) =====
// بسيط، خالص من المنطق المعقد
class AttendanceEntity {
  final String id;
  final String status;
  final DateTime date;
}

// ===== Data Layer (Model) =====
// يحتوي على تحويلات JSON، DB mapping، إلخ
@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String id,
    @Default('present') String status,
    DateTime? date,
    // ... حقول إضافية للـ API/DB
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  // تحويل Entity → Model
  factory AttendanceModel.fromEntity(AttendanceEntity entity) { ... }

  // تحويل Model → Entity
  AttendanceEntity toEntity() { ... }
}
```

#### Repository Implementation

```dart
/// تنفيذ مخزن بيانات الحضور
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AppDatabase _database;      // قاعدة البيانات المحلية
  final HttpClient _httpClient;     // عميل HTTP للخادم

  AttendanceRepositoryImpl({
    required AppDatabase database,
    required HttpClient httpClient,
  })  : _database = database,
        _httpClient = httpClient;

  @override
  Future<AttendanceEntity> submitAttendance({
    required String ip,
    required int port,
    required String sessionId,
    required Map<String, dynamic> studentData,
  }) async {
    // 1. إرسال للخادم
    final response = await _httpClient.postAttendance(
      ipAddress: ip,
      port: port,
      data: studentData,
    );

    // 2. إنشاء Model من الاستجابة
    final model = AttendanceModel.fromServerResponse(
      sessionId: sessionId,
      courseName: response.data?['course_name'] ?? '',
      status: response.success ? 'present' : 'failed',
      message: response.message,
      attendanceId: response.attendanceId,
    );

    // 3. حفظ محلياً
    await _database.addAttendanceRecord(model.toCompanion());

    // 4. إرجاع Entity
    return model.toEntity();
  }
}
```

#### Data Sources

```dart
/// مصدر البيانات: SQLite عبر Drift
class LocalDatabase {
  late final AppDatabase database;

  Future<void> init() async {
    database = AppDatabase();
  }
}

/// مصدر البيانات: Hive للتخزين المؤقت
class HiveService {
  late Box _settingsBox;
  late Box _cacheBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _settingsBox = await Hive.openBox('settings');
    _cacheBox = await Hive.openBox('cache');
  }
}

/// مصدر البيانات: SharedPreferences للإعدادات البسيطة
class SharedPrefsService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
```

---

### ⚙️ طبقة `Core`

**المسؤولية:** التكوينات والأدوات المشتركة

#### الهيكل

```
lib/core/
├── constants/
│   └── app_constants.dart         # الثوابت والرسائل
├── router/
│   └── app_router.dart            # Go Router Configuration
├── theme/
│   └── app_colors.dart            # الألوان والثيمات
├── di/
│   └── di_setup.dart              # Riverpod Providers
├── utils/
│   ├── crypto_utils.dart          # أدوات التشفير
│   └── helpers.dart               # دوال مساعدة
└── extensions/
    └── extensions.dart            # امتدادات Dart
```

---

## 🔄 MVVM Pattern

### المكونات

```
┌─────────────────────────────────────────────────────────────┐
│                         VIEW                                │
│              (Screen / Widget / UI)                         │
│                        │                                    │
│                        ▼ يعرض                               │
│                     State                                   │
│                        ▲                                    │
│                        │ يُحدث                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                   VIEWMODEL                          │   │
│  │                                                      │   │
│  │  • يحمل حالة UI                                      │   │
│  │  • يستدعي Use Cases                                  │   │
│  │  • يتعامل مع User Actions                            │   │
│  │  • يُعرض State للـ View                              │   │
│  └─────────────────────────────────────────────────────┘   │
│                        │                                    │
│                        ▼ يستدعي                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                     MODEL                             │   │
│  │                                                      │   │
│  │  • Entities                                          │   │
│  │  • Repositories                                      │   │
│  │  • Use Cases                                         │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### التنفيذ مع Riverpod

```dart
// ========== ViewModel (Provider) ==========

/// Provider لحالة الشاشة الرئيسية
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    getStudentUseCase: ref.watch(getStudentUseCaseProvider),
    submitAttendanceUseCase: ref.watch(submitAttendanceUseCaseProvider),
  ),
);

/// ViewModel
class HomeViewModel extends StateNotifier<HomeState> {
  final GetStudentUseCase _getStudentUseCase;
  final SubmitAttendanceUseCase _submitAttendanceUseCase;

  HomeViewModel({
    required GetStudentUseCase getStudentUseCase,
    required SubmitAttendanceUseCase submitAttendanceUseCase,
  })  : _getStudentUseCase = getStudentUseCase,
        _submitAttendanceUseCase = submitAttendanceUseCase,
        super(const HomeState.initial());

  /// تحميل بيانات الطالب
  Future<void> loadStudent() async {
    state = state.copyWith(isLoading: true);
    
    final result = await _getStudentUseCase.call();
    
    result.fold(
      (student) => state = state.copyWith(student: student, isLoading: false),
      (error) => state = state.copyWith(error: error, isLoading: false),
    );
  }

  /// تسجيل حضور
  Future<void> submitAttendance(QrCodeData qrData) async {
    state = state.copyWith(isSubmitting: true);
    
    final result = await _submitAttendanceUseCase.call(qrData.toParams());
    
    result.fold(
      (attendance) => state = state.copyWith(
        attendanceResult: AsyncValue.data(attendance),
        isSubmitting: false,
      ),
      (error) => state = state.copyWith(
        attendanceResult: AsyncValue.error(error),
        isSubmitting: false,
      ),
    );
  }
}

/// State
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(null) StudentEntity? student,
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default(null) String? error,
    @Required AsyncValue<AttendanceEntity>? attendanceResult,
  }) = _HomeState;
  
  const factory HomeState.initial() = _InitialHomeState;
}

// ========== View (Screen) ==========

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      body: state.isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              if (state.student != null) StudentCard(state.student!),
              ElevatedButton(
                onPressed: () => viewModel.submitAttendance(qrData),
                child: const Text('تسجيل الحضور'),
              ),
            ],
          ),
    );
  }
}
```

---

## 💉 Riverpod لإدارة الحالة

### لماذا Riverpod؟

| الميزة | الوصف |
|--------|-------|
| **Compile-time Safety** | اكتشاف الأخطاء وقت الترجمة |
| **Testability** | سهولة اختبار Providers |
| **No BuildContext** | يمكن استخدامه خارج Widgets |
| **Auto-dispose** | تنظيف تلقائي للموارد |
| **Family Parameters** | تمرير معاملات للـ Providers |

### أنواع المستخدمة

```dart
// 1. Provider - للقيم الثابتة/البسيطة
final appConstantsProvider = Provider<AppConstants>((ref) => AppConstants());

// 2. StateNotifierProvider - للحالة القابلة للتغيير
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(...);

// 3. FutureProvider - للعمليات غير المتزامنة (قراءة فقط)
final studentFutureProvider = FutureProvider<StudentEntity>((ref) async { ... });

// 4. StreamProvider - لتدفقات البيانات
final attendanceStreamProvider = StreamProvider<List<AttendanceEntity>>((ref) { ... });

// 5. ChangeNotifierProvider - (أقل استخداماً)
final settingsProvider = ChangeNotifierProvider<SettingsNotifier>((ref) { ... });
```

### Dependency Injection Setup

```dart
// lib/core/di/di_setup.dart

// ==================== Database ====================
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

// ==================== Services ====================
final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());
final sharedPrefsProvider = Provider<SharedPrefsService>((ref) => SharedPrefsService());
final httpClientProvider = Provider<HttpClient>((ref) => HttpClient());
final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

// ==================== Repositories ====================
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl(
    database: ref.watch(databaseProvider),
    hive: ref.watch(hiveServiceProvider),
    prefs: ref.watch(sharedPrefsProvider),
  );
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(
    database: ref.watch(databaseProvider),
    http: ref.watch(httpClientProvider),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    prefs: ref.watch(sharedPrefsProvider),
    database: ref.watch(databaseProvider),
  );
});

// ==================== Use Cases ====================
final getStudentUseCaseProvider = Provider<GetStudentUseCase>((ref) {
  return GetStudentUseCase(ref.watch(studentRepositoryProvider));
});

final submitAttendanceUseCaseProvider = Provider<SubmitAttendanceUseCase>((ref) {
  return SubmitAttendanceUseCase(ref.watch(attendanceRepositoryProvider));
});
```

### استخدام Providers

```dart
// قراءة (Watch - يعيد بناء عند التغيير)
final state = ref.watch(viewModelProvider);

// قراءة (Read - مرة واحدة)
final useCase = ref.read(useCaseProvider);

// تعديل (Notifier)
ref.read(viewModelProvider.notifier).doSomething();

// Invalidate (إعادة إنشاء)
ref.invalidate(apiProvider);
```

---

## 🧭 Go Router للتنقل

### لماذا Go Router؟

| الميزة | الوصف |
|--------|-------|
| **Declarative** | تعريف المسارات بشكل تصريحي |
| **Deep Linking** | دعم الروابط العميقة |
| **URL-based** | كل شاشة لها URL |
| **Nested Navigation** | تنقل متداخل (Tabs + Sub-routes) |
| **Type-safe** | تمرير البيانات بأمان |

### هيكل المسارات

```
/splash                    → SplashScreen
/setup                     → SetupScreen
/home                      → MainShell (BottomNav)
/home/scan                 → ScanQrScreen
/home/connect              → ManualConnectScreen
/home/attendance-status    → AttendanceStatusScreen
/history                   → HistoryScreen
/profile                   → ProfileScreen
/settings                  → SettingsShell
/settings/about            → AboutScreen
```

### الإعداد

```dart
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: _rootNavigatorKey,
    
    routes: [
      // Splash
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      
      // Setup
      GoRoute(path: '/setup', builder: (_, __) => const SetupScreen()),
      
      // Main Shell (مع Bottom Navigation)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) => MainShell(navShell),
        branches: [
          // الفرع الرئيسي
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomeScreen(), routes: [
              GoRoute(path: 'scan', builder: (_, __) => const ScanQrScreen()),
              GoRoute(path: 'connect', builder: (_, __) => const ManualConnectScreen()),
            ]),
            GoRoute(path: '/history', builder: (_, __) => const HistoryScreen()),
            GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
          ]),
          // فرع الإعدادات
          StatefulShellBranch(routes: [
            GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen(), routes: [
              GoRoute(path: 'about', builder: (_, __) => const AboutScreen()),
            ]),
          ]),
        ],
      ),
    ],
    
    errorBuilder: (context, state) => ErrorScreen(state.error),
  );
}
```

### التنقل بين الشاشات

```dart
// التنقل الأساسي
context.go('/home');

// التنقل مع parameters
context.go('/home/attendance-status');

// تمرير بيانات إضافية
context.go('/home/attendance-status', extra: {
  'status': 'success',
  'message': 'تم تسجيل الحضور',
});

// العودة
context.pop();

// Deep Link
GoRouter.of(context).location; // URL الحالي
```

---

## 📊 رسم توضيحي للعمارة

### الرسم الكامل

```
┌────────────────────────────────────────────────────────────────────────────┐
│                              APP ENTRY POINT                               │
│                              (main.dart)                                   │
└───────────────────────────────────┬────────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                              AttendanceStudentApp                          │
│                               (app.dart)                                   │
│  ┌──────────────────────────────────────────────────────────────────────┐ │
│  │                         ProviderScope                                 │ │
│  │  ┌─────────────────────────────────────────────────────────────────┐  │ │
│  │  │                       MaterialApp.router                        │  │ │
│  │  │                                                                 │  │ │
│  │  │  ┌─────────────────────────────────────────────────────────┐    │  │ │
│  │  │  │                    GoRouter                             │    │  │ │
│  │  │  │                                                         │    │  │ │
│  │  │  │  /splash ─────────► SplashScreen                        │    │  │ │
│  │  │  │                                                         │    │  │ │
│  │  │  │  /setup ──────────► SetupScreen                         │    │  │ │
│  │  │  │                                                         │    │  │ │
│  │  │  │  /home ──────────► MainShell ◄─────────────────────┐    │  │ │
│  │  │  │   │                  │                             │    │  │ │
│  │  │  │   │    ┌────────────┼────────────┐                │    │  │ │
│  │  │  │   │    ▼            ▼            ▼                │    │  │ │
│  │  │  │   │  HomeScreen  HistoryScreen ProfileScreen       │    │  │ │
│  │  │  │   │    │                                       │    │  │ │
│  │  │  │   │    ├── scan ► ScanQrScreen                  │    │  │ │
│  │  │  │   │    └── connect ► ManualConnectScreen         │    │  │ │
│  │  │  │   │                                            │    │  │ │
│  │  │  │  /settings ──────► SettingsShell ──► AboutScreen│    │  │ │
│  │  │  └─────────────────────────────────────────────────┘    │  │ │
│  │  └─────────────────────────────────────────────────────────┘  │ │
│  └──────────────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────────┘
```

### تدفق البيانات

```
User Action
    │
    ▼
┌─────────────┐     ┌──────────────┐     ┌────────────────┐
│    VIEW      │     │   VIEWMODEL  │     │   USE CASE     │
│  (Screen)    │────▶│  (Provider)  │────▶│  (Domain)      │
│              │◀────│              │◀────│                │
└─────────────┘     └──────┬───────┘     └───────┬────────┘
                           │                      │
                           ▼                      ▼
                   ┌──────────────┐      ┌────────────────┐
                   │  REPOSITORY  │◀─────│  REPOSITORY    │
                   │  (Interface) │      │  (Impl)        │
                   └──────┬───────┘      └───────┬────────┘
                          │                      │
                          ▼                      ▼
                   ┌──────────────┐      ┌────────────────┐
                   │ DATA SOURCE  │      │ HTTP CLIENT    │
                   │ (DB/Hive/Prefs│      │  (API Call)    │
                   └──────────────┘      └────────────────┘
```

---

## 🔀 سير البيانات

### سيناريو: تسجيل حضور جديد

```
1. USER ACTION
   └─ المستخدم يضغط "مسح QR Code"

2. VIEW (ScanQrScreen)
   └─ يستدعي: ref.read(scanQrProvider.notifier).scanQr()

3. VIEWMODEL (ScanQrNotifier)
   ├─ يفتح الكاميرا
   ├─ ينتظر نتيجة المسح
   └─ عند النجاح: يُرسل QrCodeData

4. VIEW (Confirmation Dialog)
   └─ يعرض بيانات QR ويطلب تأكيد

5. USER CONFIRMS
   └─ المستخدم يؤكد

6. VIEWMODEL (HomeViewModel)
   └─ يستدعي: submitAttendanceUseCase.call(params)

7. USE CASE (SubmitAttendanceUseCase)
   ├─ يتحقق من صحة البيانات
   └─ يستدعي: repository.submitAttendance(...)

8. REPOSITORY IMPL (AttendanceRepositoryImpl)
   ├─ يُرسل طلب HTTP عبر HttpClient
   ├─ يستقبل ServerResponse
   ├─ يحول Response إلى Model
   └─ يحفظ في Database
   └─ يُرجع Entity

9. USE CASE
   └─ يُرجع Result<Entity>

10. VIEWMODEL
    └─ يُحدث State بـ Success/Error

11. VIEW (HomeScreen)
    └─ يُعيد البناء بناءً على الجديد State
       └─ يعرض Success Message أو Error
```

---

## 📁 هيكل الملفات التفصيلي

```
lib/
│
├── main.dart                          # نقطة الدخول
├── app.dart                           # إعداد التطبيق (ProviderScope, Router)
│
├── core/                              # [Core Layer]
│   ├── constants/
│   │   └── app_constants.dart         # Constants, Messages, Errors
│   ├── di/
│   │   └── di_setup.dart              # All Riverpod Providers
│   ├── extensions/
│   │   └── extensions.dart            # Dart Extensions
│   ├── router/
│   │   └── app_router.dart            # Go Router Config
│   ├── theme/
│   │   └── app_colors.dart            # Theme & Colors
│   └── utils/
│       ├── crypto_utils.dart          # SHA-256 Hashing
│       └── helpers.dart               # Helper Functions
│
├── domain/                            # [Domain Layer] - Pure Dart!
│   ├── entities/
│   │   ├── student_entity.dart        # Student Business Object
│   │   └── attendance_entity.dart     # Attendance Business Object
│   ├── repositories/
│   │   ├── student_repository.dart    # Abstract Repository Interface
│   │   ├── attendance_repository.dart # Abstract Repository Interface
│   │   └── settings_repository.dart   # Abstract Repository Interface
│   └── use_cases/
│       ├── student_use_case.dart      # Student Business Logic
│       ├── attendance_use_case.dart   # Attendance Business Logic
│       └── settings_use_case.dart     # Settings Business Logic
│
├── data/                              # [Data Layer]
│   ├── models/                        # DTOs with serialization
│   │   ├── student_model.dart         # + .freezed.dart, .g.dart
│   │   ├── attendance_model.dart      # + .freezed.dart, .g.dart
│   │   ├── settings_model.dart        # + .freezed.dart, .g.dart
│   │   ├── connection_log_model.dart  # + .freezed.dart, .g.dart
│   │   └── server_response.dart       # + .freezed.dart, .g.dart
│   ├── data_sources/
│   │   └── local/
│   │       ├── local_database.dart    # Drift Database Definition
│   │       ├── hive_service.dart      # Hive NoSQL Cache
│   │       └── shared_prefs_service.dart # Simple Key-Value Store
│   └── repositories/                  # Implementations of Domain Interfaces
│       ├── attendance_repository_impl.dart
│       ├── student_repository_impl.dart
│       └── settings_repository_impl.dart
│
├── presentation/                      # [Presentation Layer]
│   └── screens/
│       ├── main_shell.dart            # Shell with BottomNav
│       ├── splash_screen.dart         # Launch Screen
│       ├── setup_screen.dart          # First-time Setup
│       ├── home_screen.dart           # Dashboard
│       ├── scan_qr_screen.dart        # QR Scanner
│       ├── manual_connect_screen.dart # Manual IP Input
│       ├── attendance_status_screen.dart # Result Display
│       ├── profile_screen.dart        # User Profile
│       ├── history_screen.dart        # Attendance Log
│       ├── settings_screen.dart       # App Settings
│       └── about_screen.dart          # About Page
│
└── services/                          # [External Services]
    ├── network/
    │   └── http_client.dart           # HTTP Client for API Calls
    └── notification/
        └── notification_service.dart  # Push Notifications
```

---

## 📚 مراجع إضافية

### أنماط التصميم المستخدمة

| النمط | الاستخدام |
|-------|-----------|
| **Clean Architecture** | فصل الطبقات |
| **MVVM** | فصل View عن Logic |
| **Repository** | تجريد مصادر البيانات |
| **Dependency Injection** | حقن التبعيات عبر Riverpod |
| **Observer** | Stream/Reactive updates |
| **Singleton** | Database, Services |
| **Factory** | Model creation |
| **DTO** | Data Transfer Objects |

### موارد للتعلم

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev/)
- [Go Router Package](https://pub.dev/packages/go_router)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Freezed Package](https://pub.dev/packages/freezed)

---

<p align="center">
  <strong>🏗️ آخر تحديث: يناير 2024</strong>
</p>
