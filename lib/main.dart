import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'core/app_theme_controller.dart';
import 'screens/account_screen.dart';
import 'screens/coordinator/coordinator_shell_screen.dart';
import 'screens/coordinator/data_center_screen.dart';
import 'screens/coordinator/evaluation_screen.dart';
import 'screens/coordinator/area_management_screen.dart';
import 'screens/coordinator/report_detail_screen.dart';
import 'screens/coordinator/room_management_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/password_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/user/report_upload_screen.dart';
import 'screens/user/user_shell_screen.dart';
import 'screens/user/camera_screen.dart';
import 'screens/user/photo_preview_screen.dart';
import 'screens/user/upload_success_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppThemeController.instance.load();
  runApp(const DutioApp());
}

class DutioApp extends StatelessWidget {
  const DutioApp({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppThemeController.instance,
    builder: (context, _) {
      final isDarkMode = AppThemeController.instance.isDarkMode;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dutio',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          final viewport = mediaQuery.size;
          final width = viewport.width > 430 ? 430.0 : viewport.width;
          final height = viewport.height > 932 ? 932.0 : viewport.height;
          final app = MediaQuery(
            data: mediaQuery.copyWith(size: Size(width, height)),
            child: SizedBox(
              width: width,
              height: height,
              child: child ?? const SizedBox.shrink(),
            ),
          );

          if (viewport.width <= 600) return app;

          return ColoredBox(
            color: isDarkMode
                ? DutioPalette.dark.surfaceVariant
                : AppTheme.lightGreen,
            child: Center(
              child: Container(
                width: width,
                height: height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? DutioPalette.dark.background
                      : AppTheme.cream,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: MediaQuery(
                  data: mediaQuery.copyWith(size: Size(width, height)),
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            ),
          );
        },
        initialRoute: '/opening',
        routes: {
          '/': (_) => const LoginScreen(),
          '/opening': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(),
          '/signup': (_) => const SignupScreen(),
          '/forgot-password': (_) => const ForgotPasswordScreen(),
          '/user': (_) => const UserShellScreen(),
          '/coordinator': (_) => const CoordinatorShellScreen(),
          '/coordinator/data': (_) => const DataCenterScreen(),
          '/coordinator/areas': (_) => const AreaManagementScreen(),
          '/coordinator/rooms': (_) => const RoomManagementScreen(),
          '/coordinator/evaluation': (_) => const EvaluationScreen(),
          '/coordinator/report-detail': (context) => ReportDetailScreen(
            isMission: ModalRoute.of(context)?.settings.arguments == true,
          ),
          '/user/report': (_) => const ReportUploadScreen(),
          '/user/camera': (_) => const CameraScreen(),
          '/user/photo-preview': (_) => const PhotoPreviewScreen(),
          '/user/upload-success': (_) => const UploadSuccessScreen(),
        },
        onGenerateRoute: (settings) {
          final role = settings.arguments is DutioRole
              ? settings.arguments! as DutioRole
              : DutioRole.member;
          final Widget? page = switch (settings.name) {
            '/settings' => SettingsScreen(role: role),
            '/account' => AccountScreen(role: role),
            '/notifications' => NotificationsScreen(role: role),
            '/password' => PasswordScreen(role: role),
            _ => null,
          };
          return page == null
              ? null
              : MaterialPageRoute<void>(
                  builder: (_) => page,
                  settings: settings,
                );
        },
      );
    },
  );
}
