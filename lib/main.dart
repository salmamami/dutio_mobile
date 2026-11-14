import 'package:flutter/material.dart';

import 'core/app_theme.dart';
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

void main() => runApp(const DutioApp());

class DutioApp extends StatelessWidget {
  const DutioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Dutio',
    theme: AppTheme.lightTheme,
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
          : MaterialPageRoute<void>(builder: (_) => page, settings: settings);
    },
  );
}
