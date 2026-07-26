import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavKey = GlobalKey<NavigatorState>();
  static final _historyNavKey = GlobalKey<NavigatorState>();
  static final _profileNavKey = GlobalKey<NavigatorState>();
  static final _settingsNavKey = GlobalKey<NavigatorState>();

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
        
        // الهيكل الرئيسي مع 4 فروع مستقلة
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => 
              MainShell(navigationShell: navigationShell),
          branches: [
            // الفرع 1: الرئيسية
            StatefulShellBranch(
              navigatorKey: _homeNavKey,
              routes: [
                GoRoute(
                  path: AppRoutes.home,
                  name: AppRoutes.homeName,
                  builder: (context, state) => const HomeScreen(),
                  routes: [
                    GoRoute(
                      path: 'scan',
                      name: AppRoutes.scanName,
                      builder: (context, state) => const ScanQrScreen(),
                    ),
                    GoRoute(
                      path: 'connect',
                      name: AppRoutes.connectName,
                      builder: (context, state) => const ManualConnectScreen(),
                    ),
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
              ],
            ),
            
            // الفرع 2: السجل
            StatefulShellBranch(
              navigatorKey: _historyNavKey,
              routes: [
                GoRoute(
                  path: AppRoutes.history,
                  name: AppRoutes.historyName,
                  builder: (context, state) => const HistoryScreen(),
                ),
              ],
            ),

            // الفرع 3: الملف الشخصي
            StatefulShellBranch(
              navigatorKey: _profileNavKey,
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profileName,
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),

            // الفرع 4: الإعدادات
            StatefulShellBranch(
              navigatorKey: _settingsNavKey,
              routes: [
                GoRoute(
                  path: AppRoutes.settings,
                  name: AppRoutes.settingsName,
                  builder: (context, state) => const SettingsScreen(),
                  routes: [
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
              const Text('الصفحة غير موجودة', style: TextStyle(fontFamily: 'Cairo', fontSize: 18)),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go(AppRoutes.splash),
                child: const Text('العودة للبداية', style: TextStyle(fontFamily: 'Cairo')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppRoutes {
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
