import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        // 1. مسارات مستقلة (Full Screen)
        GoRoute(
          path: AppRoutes.splash,
          name: AppRoutes.splashName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.setup,
          name: AppRoutes.setupName,
          builder: (context, state) => const SetupScreen(),
        ),
        GoRoute(
          path: AppRoutes.scan,
          name: AppRoutes.scanName,
          builder: (context, state) => const ScanQrScreen(),
        ),
        GoRoute(
          path: AppRoutes.connect,
          name: AppRoutes.connectName,
          builder: (context, state) => const ManualConnectScreen(),
        ),
        GoRoute(
          path: AppRoutes.attendanceStatus,
          name: AppRoutes.attendanceStatusName,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return AttendanceStatusScreen(
              status: extra?['status'] ?? '',
              message: extra?['message'] ?? '',
            );
          },
        ),

        // 2. الهيكل الرئيسي (مع القائمة السفلية)
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => 
              MainShell(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.home,
                  name: AppRoutes.homeName,
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.history,
                  name: AppRoutes.historyName,
                  builder: (context, state) => const HistoryScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profileName,
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
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
      
      errorBuilder: (context, state) => const Scaffold(
        body: Center(child: Text('عذراً، حدث خطأ في المسار')),
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
  static const String scan = '/scan';
  static const String scanName = 'scan';
  static const String connect = '/connect';
  static const String connectName = 'connect';
  static const String attendanceStatus = '/status';
  static const String attendanceStatusName = 'status';
  static const String history = '/history';
  static const String historyName = 'history';
  static const String profile = '/profile';
  static const String profileName = 'profile';
  static const String settings = '/settings';
  static const String settingsName = 'settings';
  static const String about = 'about';
  static const String aboutName = 'about';
}
