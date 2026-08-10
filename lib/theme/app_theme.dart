import 'package:flutter/material.dart';
import 'app_color_scheme.dart';

/// Builds the two ThemeData objects the app switches between.
/// MaterialApp gets both (theme: AppTheme.light, darkTheme: AppTheme.dark)
/// and ThemeMode decides which one is active — see theme_mode_provider.dart.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colors = AppColorScheme.light();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
    );
  }

  static ThemeData get dark {
    final colors = AppColorScheme.dark();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      
      extensions: [colors],
    );
  }
}
