import 'package:flutter/material.dart';

/// This gradient is intentionally NOT tied to context.appColors — it's
/// brand styling for the pre-login screens, and stays the same dark purple
/// regardless of whether the user later picks light or dark mode inside
/// the app. Only the white sheet below it (built by each screen) adapts
/// to the theme.
class AuthBrandHeader extends StatelessWidget {
  final Widget? trailing; // optional content below the logo, e.g. the store badge

  const AuthBrandHeader({super.key, this.trailing});

  static const _gradientTop = Color(0xFF1B1330);
  static const _gradientBottom = Color(0xFF120C24);
  static const _accent = Color(0xFF8B7CF6);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_gradientTop, _gradientBottom],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 16),
          const Text(
            'ALFASUN',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 2),
          const Text(
            'POS PLATFORM',
            style: TextStyle(color: Color(0xFF8D8AA3), fontSize: 11, letterSpacing: 3),
          ),
          if (trailing != null) ...[const SizedBox(height: 20), trailing!],
        ],
      ),
    );
  }
}
