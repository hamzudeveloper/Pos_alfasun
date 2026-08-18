/// The signed-in user's profile info. No data/repository layer here on
/// purpose — there's no auth backend yet, so this is a single mocked
/// value exposed via a provider (see user_profile_provider.dart). When
/// real auth exists, only that provider needs to change.
class UserProfileEntity {
  final String fullName;
  final String email;
  final String role;

  const UserProfileEntity({
    required this.fullName,
    required this.email,
    required this.role,
  });

  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
