import 'package:flutter/material.dart';

class LightAppColors {
  // ---------- Primary Palette (Blue Theme) ----------
  static const Color primary900 = Color(0xFF1E3A8A); // Deep Blue
  static const Color primary800 = Color(0xFF2C5AA0); // Dark Blue
  static const Color primary700 = Color(0xFF3B82F6); // Strong Blue
  static const Color primary600 = Color(0xFF4A90E2); // Medium Blue
  static const Color primary500 = Color(0xFF5BA3F5); // Bright Blue
  static const Color primary400 = Color(0xFF60A5FA); // Light Blue
  static const Color primary300 = Color(
    0xFFE8F4FD,
  ); // Very Light Blue (backgrounds)

  // ---------- Grey Scale ----------
  static const Color grey900 = Color(0xFF011308);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey100 = Color(0xFFDFE1E7);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey0 = Color(0xFFFFFFFF);

  // ---------- Neutral ----------
  static const Color background = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color neutral800 = Color(0xFF2C3E50);
  static const Color neutral700 = Color(0xFF4D4D4D);
  static const Color neutral300 = Color(0xFF6C757D);
  // ---------- Status ----------
  static const Color error900 = Color(0xFF93000A);
  static const Color error700 = Color(0xFFDF1C41);
  static const Color error500 = Color(0xFFEF4444);

  static const Color warning500 = Color(0xFFF59E0B);

  static const Color info900 = Color(0xFF1E40AF);
  static const Color info700 = Color(0xFF2563EB);

  static const Color info500 = Color(0xFF6B21A8);
  static const Color info300 = Color(0xFF8B5CF6);

  static const Color accent700 = Color(0xFFEA580C);
  static const Color accent600 = Color(0xFF4B5563);
  static const Color accent300 = Color(0xFFE5E7EB);

  // ---------- Gradients ----------
  static const List<Color> blueGradient = [
    Color(0xFF4A90E2),
    Color(0xFF5BA3F5),
  ];

  static const List<Color> deepBlueGradient = [
    Color(0xFF2C5AA0),
    Color(0xFF4A90E2),
  ];

  static const List<Color> lightBlueGradient = [
    Color(0xFF60A5FA),
    Color(0xFF93C5FD),
  ];

  static const List<Color> bluePurpleGradient = [
    Color(0xFF4A90E2),
    Color(0xFF9C27B0),
  ];

  static const List<Color> orangeGradient = [
    Color(0xFFF59E0B),
    Color(0xFFEA580C),
  ];

  static const List<Color> yellowGradient = [
    Color(0xFFFCD34D),
    Color(0xFFEAB308),
  ];

  static List<Color> blueYellowGradient = [
    const Color(0xFF4A90E2).withValues(alpha: .1),
    const Color(0xFFF59E0B).withValues(alpha: .1),
  ];

  // ---------- Additional Blue Shades ----------
  static const Color blueLight = Color(0xFFD1E7F8);
  static const Color blueLighter = Color(0xFFF0F8FF);
  static const Color blueAccent = Color(0xFF17A2B8);
}
