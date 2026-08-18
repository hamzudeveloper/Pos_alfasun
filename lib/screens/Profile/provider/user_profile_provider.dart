import 'package:alfasun_pos/Screens/Profile/Widgets/user_profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mocked "current user" — swap this for a real fetch once auth exists.
/// Matches the manager persona already used across the dashboard/reports screens.
final currentUserProvider = Provider<UserProfileEntity>((ref) {
  return const UserProfileEntity(
    fullName: 'Hamzu',
    email: 'hamzu.dev@gmail.com',
    role: 'Manager',
  );
});

/// Just a local on/off preference for now — not wired into the actual
/// notifications feature's data yet, it's the "Notifications" switch on
/// the Profile screen only.
final notificationsPreferenceProvider = StateProvider<bool>((ref) => true);
