// customer_home_screen.dart


import 'package:alfasun_pos/Screens/DummyForAPI/data_model.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatelessWidget {
  final LoginData loginData;

  const CustomerHomeScreen({super.key, required this.loginData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, ${loginData.user.name}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Welcome to Qhelo Sports Store"),
          ],
        ),
      ),
    );
  }
}