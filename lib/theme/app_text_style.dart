import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._(); // prevents creating instances of this class

  static const TextStyle header = TextStyle(
    color: AppColors.textWhite,
    fontSize: 26,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static const TextStyle subHeader = TextStyle(
    color: AppColors.textWhite,
    fontSize: 16,
    letterSpacing: 1.2,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.textGrey,
    fontSize: 14,
    letterSpacing: 1.0,
  );

  static const TextStyle button = TextStyle(
    color: AppColors.textWhite,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static const TextStyle numbers = TextStyle(
    // color: AppColors.textWhite,
    fontSize: 12,
    letterSpacing: 0.8,
  );
}
