import 'package:alfasun_pos/screens/dashboard/widgets/manager_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_providers.dart';
import '../../theme/app_colors.dart';

class PinEntryScreen extends ConsumerWidget {
  const PinEntryScreen({super.key});

  String _roleLabel(UserRole? role) {
    switch (role) {
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.manager:
        return 'Manager';
      case null:
        return '';
    }
  }

  IconData _roleIcon(UserRole? role) {
    switch (role) {
      case UserRole.cashier:
        return Icons.shopping_cart_outlined;
      case UserRole.manager:
        return Icons.grid_view_rounded;
      case null:
        return Icons.person_outline;
    }
  }

  void _handleDigit(BuildContext context, WidgetRef ref, String digit) {
    ref.read(pinProvider.notifier).addDigit(digit);

    // After the state updates, check if we now have 4 digits.
    final pin = ref.read(pinProvider);
    if (pin.length == PinNotifier.pinLength) {
      _attemptLogin(context, ref, pin);
    }
  }

  void _attemptLogin(BuildContext context, WidgetRef ref, String pin) {
    final role = ref.read(selectedRoleProvider);

    if (pin == demoPin) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const ManagerDashboardScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in as ${_roleLabel(role)} ✅')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect PIN, try again')));
    }

    // Either way, clear the pin so the user can try again / next person can log in.
    ref.read(pinProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() here means: whenever the pin changes, this build() re-runs
    // and the dots + everything below update automatically.
    final pin = ref.watch(pinProvider);
    final role = ref.watch(selectedRoleProvider);

    return Scaffold(
      backgroundColor: AppColors.sheetBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Top bar: back arrow + role chip ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () {
                      ref.read(pinProvider.notifier).clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _roleIcon(role),
                          size: 16,
                          color: AppColors.primaryPurple,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _roleLabel(role),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40), // balances the back button's width
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Enter PIN',
              style: TextStyle(fontSize: 15, color: AppColors.textGrey),
            ),
            const SizedBox(height: 20),

            // ---------- 4 progress dots ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(PinNotifier.pinLength, (index) {
                final filled = index < pin.length;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled
                        ? AppColors.primaryPurple
                        : AppColors.cardBackground,
                    border: Border.all(
                      color: filled
                          ? AppColors.primaryPurple
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
            ),

            const Spacer(),

            // ---------- Numeric keypad ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _KeypadRow(
                    labels: const ['1', '2', '3'],
                    onTap: (d) => _handleDigit(context, ref, d),
                  ),
                  const SizedBox(height: 16),
                  _KeypadRow(
                    labels: const ['4', '5', '6'],
                    onTap: (d) => _handleDigit(context, ref, d),
                  ),
                  const SizedBox(height: 16),
                  _KeypadRow(
                    labels: const ['7', '8', '9'],
                    onTap: (d) => _handleDigit(context, ref, d),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 75,
                      ), // empty bottom-left slot
                      _KeypadButton(
                        label: '0',
                        onTap: () => _handleDigit(context, ref, '0'),
                      ),
                      _KeypadButton(
                        icon: Icons.backspace_outlined,
                        isDelete: true,
                        onTap: () =>
                            ref.read(pinProvider.notifier).removeDigit(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Enter all 4 digits to sign in automatically',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dashboard Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.dashboard, size: 100, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class _KeypadRow extends StatelessWidget {
  final List<String> labels;
  final ValueChanged<String> onTap;

  const _KeypadRow({required this.labels, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels
          .map(
            (label) => _KeypadButton(label: label, onTap: () => onTap(label)),
          )
          .toList(),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool isDelete;
  final VoidCallback onTap;

  const _KeypadButton({
    this.label,
    this.icon,
    this.isDelete = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 100,
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDelete
              ? AppColors.deleteKeyBackground
              : AppColors.keyBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: label != null
            ? Text(
                label!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              )
            : Icon(icon, color: AppColors.deleteKeyIcon),
      ),
    );
  }
}
