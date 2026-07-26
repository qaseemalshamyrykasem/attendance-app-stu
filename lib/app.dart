/// التطبيق الرئيسي
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_colors.dart';
import 'core/router/app_router.dart';
import 'core/di/di_setup.dart';

class AttendanceStudentApp extends ConsumerStatefulWidget {
  const AttendanceStudentApp({super.key});

  @override
  ConsumerState<AttendanceStudentApp> createState() => _AttendanceStudentAppState();
}

class _AttendanceStudentAppState extends ConsumerState<AttendanceStudentApp> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // تحميل وضع الثيم
    await ref.read(themeModeProvider.notifier).loadThemeMode();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'حضوري - نظام الحضور الذكي',
      debugShowCheckedModeBanner: false,

      theme: AppThemeLight.theme,
      darkTheme: AppThemeDark.theme,
      themeMode: themeMode,

      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: AppRouter.createRouter(),

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
