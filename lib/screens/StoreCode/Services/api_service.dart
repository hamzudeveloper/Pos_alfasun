// auth_service.dart
import 'dart:convert';
import 'package:alfasun_pos/Screens/DummyForAPI/data_model.dart';
import 'package:http/http.dart' as http;


class AuthService {
  static const String baseUrl = "https://sports.qhelopakistan.com/api";

  Future<LoginResponse> login({
    required String storeCode,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "store_code": storeCode,
        "username": username,
        "password": password,
      }),
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(responseData);
    } else {
      throw Exception(responseData['message'] ?? "Login failed");
    }
  }
}