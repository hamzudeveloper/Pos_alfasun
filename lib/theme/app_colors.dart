import 'package:flutter/material.dart';

/// All colors used in the login flow, kept in one place so you're not
/// hunting for hex codes across screens.
class AppColors {
  AppColors._(); // prevents creating instances of this class

  // Dark header background (the top purple/navy section)
  static const Color bg = Color(0xFF090979);
  static const Color darkBgTop = Color(0xFF1B1330);
  static const Color darkBgBottom = Color(0xFF120C24);

  // The accent purple used for the icon, buttons, selected states
  static const Color primaryPurple = Color(0xFF8B7CF6);
  static const Color primaryPurpleLight = Color(0xFFA79BFA);

  // Light bottom sheet background
  static const Color sheetBackground = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF5F4FA);

  // Text colors
  static const Color textDark = Color(0xFF1B1330);
  static const Color textGrey = Color(0xFF8A8798);
  static const Color textWhite = Colors.white;

  // Keypad
  static const Color keyBackground = Color(0xFFF0EFF6);
  static const Color deleteKeyBackground = Color(0xFFFCE4E4);
  static const Color deleteKeyIcon = Color(0xFFE57373);

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkBgTop, darkBgBottom],
  );
}
