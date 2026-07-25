/// إعداد Go Router للتنقل
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
      // شاشة البداية
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      
      // الإعداد الأولي
      GoRoute(
        path: AppRoutes.setup,
        name: AppRoutes.setupName,
        builder: (context, state) => const SetupScreen(),
      ),
      
      // الشاشة الرئيسية
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => 
            MainShell(navigationShell: navigationShell),
        branches: [
          // الفرع الرئيسي - الرئيسية والملف الشخصي
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.homeName,
                builder: (context, state) => const HomeScreen(),
                routes: [
                  // مسح QR
                  GoRoute(
                    path: 'scan',
                    name: AppRoutes.scanName,
                    builder: (context, state) => const ScanQrScreen(),
                  ),
                  // اتصال يدوي
                  GoRoute(
                    path: 'connect',
                    name: AppRoutes.connectName,
                    builder: (context, state) => const ManualConnectScreen(),
                  ),
                  // حالة الحضور
                  GoRoute(
                    path: 'attendance-status',
                    name: AppRoutes.attendanceStatusName,
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return AttendanceStatusScreen(
                        status: extra?['status'] ?? '',
                        message: extra?['message'] ?? '',
                      );
                    },
                  ),
                ],
              ),
              
              // سجل الحضور
              GoRoute(
                path: AppRoutes.history,
                name: AppRoutes.historyName,
                builder: (context, state) => const HistoryScreen(),
              ),
              
              // الملف الشخصي
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profileName,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          
          // فرع الإعدادات
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: AppRoutes.settingsName,
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  // حول التطبيق
                  GoRoute(
                    path: 'about',
                    name: AppRoutes.aboutName,
                    builder: (context, state) => const AboutScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'صفحة غير موجودة',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('العودة للرئيسية', style: TextStyle(fontFamily: 'Cairo')),
            ),
          ],
        ),
      ),
    ),
  );
  }
}

/// أسماء المسارات
class AppRoutes {
  AppRoutes._();
  
  static const String splash = '/splash';
  static const String splashName = 'splash';
  
  static const String setup = '/setup';
  static const String setupName = 'setup';
  
  static const String home = '/home';
  static const String homeName = 'home';
  
  static const String scan = 'scan';
  static const String scanName = 'scan';
  
  static const String connect = 'connect';
  static const String connectName = 'connect';
  
  static const String attendanceStatus = 'attendance-status';
  static const String attendanceStatusName = 'attendance-status';
  
  static const String history = '/history';
  static const String historyName = 'history';
  
  static const String profile = '/profile';
  static const String profileName = 'profile';
  
  static const String settings = '/settings';
  static const String settingsName = 'settings';
  
  static const String about = 'about';
  static const String aboutName = 'about';
}
