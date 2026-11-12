
import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/mission_screen.dart';

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
      home: const MissionScreen(),
    );
  }
}
