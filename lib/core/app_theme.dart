
import 'package:flutter/material.dart';

class AppTheme {
  static const Color cream = Color(0xFFFFF9E8);
  static const Color sage = Color(0xFF89977E);
  static const Color darkGreen = Color(0xFF176B3A);
  static const Color lightGreen = Color(0xFFE8EEDC);
  static const Color dark = Color(0xFF30352D);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.fromSeed(
        seedColor: sage,
        primary: sage,
        secondary: darkGreen,
        surface: cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: dark,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
