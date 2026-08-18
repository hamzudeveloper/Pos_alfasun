// admin_dashboard_screen.dart
import 'package:alfasun_pos/Screens/DummyForAPI/data_model.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  final LoginData loginData;

  const AdminDashboardScreen({super.key, required this.loginData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard - ${loginData.branch!.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${loginData.user.name}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Role: ${loginData.roles.join(', ')}"),
            Text("Branch Code: ${loginData.branch?.code ?? "N/A"}"),
            const SizedBox(height: 24),
            const Card(
              child: ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text("Admin Controls"),
                subtitle: Text("Manage stores, orders, and branch metrics"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
