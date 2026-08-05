import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The two roles a user can log in as.
/// Using an enum instead of a raw String avoids typos like "Cashier " vs "cashier".
enum UserRole { cashier, manager }

/// Demo PIN — later this will come from your backend/auth logic.
/// Both roles share this PIN for now, matching your design's hint text.
const String demoPin = '1234';

/// ---------------------------------------------------------------------
/// 1) selectedRoleProvider
/// ---------------------------------------------------------------------
/// This is a StateProvi
/// Think of it as a single boxder — the simplest kind of provider in Riverpod. that holds one value (here: the chosen role,
/// or null if nobody picked one yet).
///
/// To read it in a widget:      ref.watch(selectedRoleProvider)
/// To change it from anywhere:  ref.read(selectedRoleProvider.notifier).state = UserRole.manager;
final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);

/// ---------------------------------------------------------------------
/// 2) PinNotifier + pinProvider
/// ---------------------------------------------------------------------
/// The PIN needs more than "just store a value" — it needs behavior:
/// add a digit, remove the last digit, clear it, check if it's complete.
/// That's exactly when you reach for a StateNotifier instead of a StateProvider.
///
/// A StateNotifier is a class that:
///   - holds a piece of state (here, a String of digits typed so far)
///   - exposes methods that change that state
///   - whenever `state = something` is set, every widget watching it rebuilds
class PinNotifier extends StateNotifier<String> {
  PinNotifier() : super(''); // starts as an empty string, no digits typed yet

  static const int pinLength = 4;

  /// Called when the user taps a number key (0-9)
  void addDigit(String digit) {
    if (state.length >= pinLength) return; // already 4 digits, ignore extra taps
    state = state + digit; // reassigning `state` is what triggers a rebuild
  }

  /// Called when the user taps the backspace key
  void removeDigit() {
    if (state.isEmpty) return;
    state = state.substring(0, state.length - 1);
  }

  /// Called after a successful/failed login attempt, or when leaving the screen
  void clear() {
    state = '';
  }

  bool get isComplete => state.length == pinLength;
}

/// StateNotifierProvider connects our PinNotifier class to the widget tree.
/// ref.watch(pinProvider) gives you the current PIN string (e.g. "12").
/// ref.read(pinProvider.notifier) gives you the PinNotifier itself,
/// so you can call .addDigit(), .removeDigit(), .clear().
final pinProvider = StateNotifierProvider<PinNotifier, String>((ref) {
  return PinNotifier();
});