// credentials_screen.dart
import 'package:alfasun_pos/Screens/DummyForAPI/customer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admin_dashboard_screen.dart';
import 'auth_provider.dart';

class CredentialsScreen extends ConsumerStatefulWidget {
  final String storeCode;

  const CredentialsScreen({super.key, required this.storeCode});

  @override
  ConsumerState<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends ConsumerState<CredentialsScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for state changes (success navigation or error alerts)
    ref.listen<AsyncValue<dynamic>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (loginData) {
          if (loginData != null) {
            // Check user_type for routing
            if (loginData.userType.toLowerCase() == "user") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => AdminDashboardScreen(loginData: loginData),
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

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
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
    );
  }
}
