import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';


/// Shown for any tab whose real screen hasn't been built yet.
/// Delete each usage of this as you build out Stock/Orders/Reports/Alerts —
/// it's a stand-in, not a permanent screen.
class AlertScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const AlertScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: colors.textSecondary),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text('Coming soon', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }
}