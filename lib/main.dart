
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/mission_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/photo_preview_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/upload_success_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const DutioApp());
}

class DutioApp extends StatelessWidget {
  const DutioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dutio',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {
        '/mission': (context) => const MissionScreen(),
        '/camera': (context) => const CameraScreen(),
        '/photo-preview': (context) => const PhotoPreviewScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/upload-success': (context) => const UploadSuccessScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
