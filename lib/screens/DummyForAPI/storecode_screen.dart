// store_code_screen.dart
import 'package:alfasun_pos/Screens/DummyForAPI/cridintials_scren.dart';
import 'package:flutter/material.dart';


class StoreCodeScreeen extends StatefulWidget {
  const StoreCodeScreeen({super.key});

  @override
  State<StoreCodeScreeen> createState() => _StoreCodeScreenState();
}

class _StoreCodeScreenState extends State<StoreCodeScreeen> {
  final TextEditingController _storeCodeController = TextEditingController();

  void _navigateToLogin() {
    String storeCode = _storeCodeController.text.trim();
    
    // Navigate to Credentials Screen and pass the storeCode
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CredentialsScreen(storeCode: storeCode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Store Code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _storeCodeController,
              decoration: InputDecoration(
                labelText: "Store Code (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToLogin,
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}