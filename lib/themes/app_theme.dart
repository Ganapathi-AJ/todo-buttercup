import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6A7FDB),
      secondary: Color(0xFF8F60DE),
      tertiary: Color(0xFFB160DE),
      background: Color(0xFFF5F7FB),
      surface: Colors.white,
      error: Color(0xFFE53935),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F7FB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF6A7FDB)),
      titleTextStyle: TextStyle(
        color: Color(0xFF2E3440),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6A7FDB),
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      focusColor: const Color(0xFF6A7FDB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF6A7FDB), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E3440),
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E3440),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF2E3440),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF4C566A),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFECEFF4),
      thickness: 1,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF81A1F8),
      secondary: Color(0xFFA98AEF),
      tertiary: Color(0xFFCB8AEF),
      background: Color(0xFF2E3440),
      surface: Color(0xFF3B4252),
      error: Color(0xFFF77F7F),
    ),
    scaffoldBackgroundColor: const Color(0xFF2E3440),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3B4252),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF81A1F8)),
      titleTextStyle: TextStyle(
        color: Color(0xFFECEFF4),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF3B4252),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF81A1F8),
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF3B4252),
      focusColor: const Color(0xFF81A1F8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF81A1F8), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFECEFF4),
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFECEFF4),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFFECEFF4),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFD8DEE9),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF4C566A),
      thickness: 1,
    ),
  );
} 