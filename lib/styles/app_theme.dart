import 'package:flutter/material.dart';

class AppTheme {
  /// 🔵 PRIMARY COLOR
  static const Color primary = Color(0xFF1976D2);

  /// ⚪ BACKGROUND
  static const Color background = Colors.white;

  /// ⚫ TEXT
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;

  /// 🔴 ERROR
  static const Color error = Colors.red;

  /// 🎨 THEME DATA
  static ThemeData light = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,

    /// 🔥 APPBAR
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// 🔥 BUTTON
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    /// 🔥 INPUT
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}