import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF8B4513);
  static const Color secondaryColor = Color(0xFFD2691E);
  static const Color accentColor = Color(0xFFF4A460);
  static const Color backgroundColor = Color(0xFFFFF8DC);
  static const Color surfaceColor = Colors.white;
  
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(0xFF8B4513, {
        50: const Color(0xFFFFF8DC),
        100: const Color(0xFFFFE4B5),
        200: const Color(0xFFDEB887),
        300: const Color(0xFFD2691E),
        400: const Color(0xFFCD853F),
        500: primaryColor,
        600: const Color(0xFF8B4513),
        700: const Color(0xFF654321),
        800: const Color(0xFF4A2C17),
        900: const Color(0xFF2F1B0C),
      }),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardTheme: const CardThemeData(
        color: surfaceColor,
        elevation: 4,
        margin: EdgeInsets.all(8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}