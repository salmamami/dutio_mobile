import 'package:flutter/material.dart';

enum DutioRole { member, coordinator }

class AppTheme {
  static const Color cream = Color(0xFFFFF8DE);
  static const Color sage = Color(0xFF84917D);
  static const Color darkGreen = Color(0xFF176B3A);
  static const Color lightGreen = Color(0xFFE7EBD9);
  static const Color charcoal = Color(0xFF7C7D78);
  static const Color blush = Color(0xFFEF9FA1);
  static const Color ink = Color(0xFF171914);
  static const Color dark = Color(0xFF30352D);
  static const Color white = Color(0xFFFFFDF4);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkGreen,
      primary: darkGreen,
      secondary: sage,
      surface: cream,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: cream,
      foregroundColor: dark,
      elevation: 0,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppTheme.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
