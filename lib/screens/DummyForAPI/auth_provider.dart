// auth_controller.dart
import 'package:alfasun_pos/Screens/DummyForAPI/api_service.dart';
import 'package:alfasun_pos/Screens/DummyForAPI/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authControllerProvider =
    AsyncNotifierProvider<AuthController, LoginData?>(() {
      return AuthController();
    });

class AuthController extends AsyncNotifier<LoginData?> {
  @override
  Future<LoginData?> build() async {
    // Return initial state (e.g. check saved token from secure storage here)
    return null;
  }

  Future<void> login({
    required String storeCode,
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final authService = ref.read(authServiceProvider);
      final response = await authService.login(
        storeCode: storeCode,
        username: username,
        password: password,
      );

      if (response.success && response.data != null) {
        return response.data;
      } else {
        throw Exception(response.message);
      }
    });
  }
}
