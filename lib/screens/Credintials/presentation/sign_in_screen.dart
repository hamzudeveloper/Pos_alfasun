import 'package:alfasun_pos/Master/shell_screen.dart';
import 'package:alfasun_pos/Screens/Dashboard/widgets/manager_dashboard_screen.dart';
import 'package:alfasun_pos/Screens/DummyForAPI/auth_provider.dart';
import 'package:alfasun_pos/Screens/DummyForAPI/customer_home_screen.dart';
import 'package:alfasun_pos/Screens/DummyForAPI/data_model.dart';
import 'package:alfasun_pos/Screens/StoreCode/Widgets/store_badge.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/auth_brand_header.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/credential_field.dart';

/// Deliberately generic — no manager/cashier/customer branching here.
/// Username + password go to the backend; the backend decides who this
/// person is and what they can do. This screen doesn't need to know.
class SignInScreen extends ConsumerStatefulWidget {
  final String storeCode;
  final LoginData loginData;

  const SignInScreen({
    super.key,
    required this.storeCode,
    required this.loginData,
  });

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // TODO (API day): call the real sign-in endpoint here, e.g.
    //   final result = await authRepository.signIn(
    //     storeCode: widget.storeCode,
    //     username: _username,
    //     password: _password,
    //   );
    // The backend response decides the role/permissions — nothing here
    // needs to change to support that; this screen doesn't ask "which role".
    // For now (no backend yet), just proceed into the app:
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MainShellScreen(loginData: widget.loginData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<dynamic>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (loginData) {
          if (loginData != null) {
            // Check user_type for routing
            if (loginData.userType.toLowerCase() == "user") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => ManagerDashboardScreen(loginData: loginData),
                ),
                (route) => false,
              );
            } else if (loginData.userType.toLowerCase() == "customer") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomerHomeScreen(loginData: loginData),
                ),
                (route) => false,
              );
            }
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString().replaceAll("Exception: ", "")),
            ),
          );
        },
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthBrandHeader(
              trailing: StoreBadge(
                storeCode: widget.storeCode,
                onChangeStore: () => Navigator.of(context).pop(),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: colors.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Text(
                    'Sign in to Store #${widget.storeCode}',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enter your credentials to continue',
                    style: TextStyle(color: colors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  CredentialField(
                    label: 'Username',
                    hint: 'Enter your username',
                    icon: Icons.person_outline,
                    controller: _usernameController,
                    onChanged: (value) =>
                        setState(() => _usernameController.text = value),
                  ),
                  const SizedBox(height: 16),
                  CredentialField(
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline_rounded,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onChanged: (value) =>
                        setState(() => _passwordController.text = value),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19,
                        color: colors.textSecondary,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  const SizedBox(height: 24),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .login(
                                  storeCode: widget.storeCode,
                                  username: _usernameController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                          },
                          child: const Text("Login"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
