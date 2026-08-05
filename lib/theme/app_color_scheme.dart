import 'package:flutter/material.dart';

/// Every color that changes between light & dark mode lives here, in ONE place.
/// Widgets never hardcode a color — they always read it from this extension via:
///
///   final colors = context.appColors;
///
/// This is what makes theme switching automatic: change ThemeMode, and every
/// widget using context.appColors rebuilds with the right palette. No if/else
/// scattered across widgets checking "is it dark mode?".
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color background;
  final Color surface; // cards, sheets
  final Color surfaceVariant; // slightly different card, e.g. stat card bg
  final Color primary; // the purple accent
  final Color textPrimary;
  final Color textSecondary;
  final Color success; // green "+12.5%" pills
  final Color danger; // red "-1.4%" pills, critical stock
  final Color warning; // orange stock alerts
  final Color border;
  final Color chartLine;
  final Color chartFill;
  final Color navBackground;
  final Color navSelected;
  final Color navUnselected;

  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.danger,
    required this.warning,
    required this.border,
    required this.chartLine,
    required this.chartFill,
    required this.navBackground,
    required this.navSelected,
    required this.navUnselected,
  });

  /// Palette matching image 1 & 2 (white background dashboard)
  factory AppColorScheme.light() {
    return const AppColorScheme(
      background: Color(0xFFF6F5FA),
      surface: Colors.white,
      surfaceVariant: Color(0xFFF5F4FA),
      primary: Color(0xFF8B7CF6),
      textPrimary: Color(0xFF1B1330),
      textSecondary: Color(0xFF8A8798),
      success: Color(0xFF34C471),
      danger: Color(0xFFE05B5B),
      warning: Color(0xFFF5A623),
      border: Color(0xFFEDEBF3),
      chartLine: Color(0xFF8B7CF6),
      chartFill: Color(0x338B7CF6),
      navBackground: Colors.white,
      navSelected: Color(0xFF8B7CF6),
      navUnselected: Color(0xFFB3B0C2),
    );
  }

  /// Palette matching image 3 & 4 (dark navy dashboard)
  factory AppColorScheme.dark() {
    return const AppColorScheme(
      background: Color(0xFF13101F),
      surface: Color(0xFF1D1930),
      surfaceVariant: Color(0xFF262138),
      primary: Color(0xFFA79BFA),
      textPrimary: Colors.white,
      textSecondary: Color(0xFF8D8AA3),
      success: Color(0xFF4ADE80),
      danger: Color(0xFFF87171),
      warning: Color(0xFFFBBF24),
      border: Color(0xFF2E2A42),
      chartLine: Color(0xFFA79BFA),
      chartFill: Color(0x33A79BFA),
      navBackground: Color(0xFF1D1930),
      navSelected: Color(0xFFA79BFA),
      navUnselected: Color(0xFF5C5875),
    );
  }

  @override
  AppColorScheme copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? primary,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? danger,
    Color? warning,
    Color? border,
    Color? chartLine,
    Color? chartFill,
    Color? navBackground,
    Color? navSelected,
    Color? navUnselected,
  }) {
    return AppColorScheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      primary: primary ?? this.primary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      border: border ?? this.border,
      chartLine: chartLine ?? this.chartLine,
      chartFill: chartFill ?? this.chartFill,
      navBackground: navBackground ?? this.navBackground,
      navSelected: navSelected ?? this.navSelected,
      navUnselected: navUnselected ?? this.navUnselected,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      border: Color.lerp(border, other.border, t)!,
      chartLine: Color.lerp(chartLine, other.chartLine, t)!,
      chartFill: Color.lerp(chartFill, other.chartFill, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
      navSelected: Color.lerp(navSelected, other.navSelected, t)!,
      navUnselected: Color.lerp(navUnselected, other.navUnselected, t)!,
    );
  }
}

/// Shortcut so widgets can write `context.appColors` instead of
/// `Theme.of(context).extension<AppColorScheme>()!`
extension AppColorSchemeX on BuildContext {
  AppColorScheme get appColors => Theme.of(this).extension<AppColorScheme>()!;
}
