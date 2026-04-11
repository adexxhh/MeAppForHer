import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color cream = Color(0xFFFAF8F0);
  static const Color pastelYellow = Color(0xFFFDE173);
  static const Color sageGreen = Color(0xFFAECFA0);
  static const Color babyBlue = Color(0xFFADCAF5);
  static const Color bubblegumPink = Color(0xFFFFB3D5);
  
  static const Color starkBlack = Color(0xFF141414);
  static const Color starkWhite = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: cream,
      primaryColor: starkBlack,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: starkBlack,
        displayColor: starkBlack,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: starkBlack,
          foregroundColor: starkWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: starkBlack,
        secondary: bubblegumPink,
        surface: cream,
      ),
    );
  }
}
