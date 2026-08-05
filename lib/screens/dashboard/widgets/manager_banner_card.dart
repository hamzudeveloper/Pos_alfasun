import 'package:alfasun_pos/screens/dashboard/widgets/date_formatter.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class ManagerBannerCard extends StatelessWidget {
  final String managerName;
  final DateTime lastSyncedAt;
  final bool isOnline;

  const ManagerBannerCard({
    super.key,
    required this.managerName,
    required this.lastSyncedAt,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final now = DateTime.now();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primary, colors.primary.withValues(alpha: 0.75)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MANAGER DASHBOARD',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              if (isOnline)
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Online',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${DateFormatter.greeting(now)}, $managerName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormatter.full(now),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Last sync: ${DateFormatter.time(lastSyncedAt)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
