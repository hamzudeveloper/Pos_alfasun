import 'package:alfasun_pos/Common/app_image.dart';
import 'package:alfasun_pos/Screens/Credintials/presentation/sign_in_screen.dart';
import 'package:alfasun_pos/Screens/StoreCode/widgets/store_code_field.dart';
import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:alfasun_pos/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// The app's entry point (see main.dart). No role selection here — just a
/// store code. Role/permissions are entirely a backend concern, decided
/// from the credentials on the next screen.
class StoreCodeScreen extends StatefulWidget {
  const StoreCodeScreen({super.key});

  @override
  State<StoreCodeScreen> createState() => _StoreCodeScreenState();
}

class _StoreCodeScreenState extends State<StoreCodeScreen> {
  final _storeCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _storeCodeController.clear();
  }

  @override
  void dispose() {
    _storeCodeController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    String storeCode = _storeCodeController.text.trim();

    // Navigate to Credentials Screen and pass only the storeCode.
    // LoginData doesn't exist yet — the API returns it after sign-in.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(storeCode: storeCode),
      ),
    );
    _storeCodeController.clear();
  }

  // void _connect() {
  //   final inputCode = _storeCodeController.text.trim().toString();

  //   // 2. Validate input against the code
  //   if (inputCode == _code.trim()) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (_) => SignInScreen(storeCode: inputCode)),
  //     );
  //   } else {
  //     return;
  //   }

  //   // TODO (API): replace with a real lookup —
  //   //   final store = await storeRepository.getStoreByCode(_code);
  //   // and pass the resolved store forward instead of just the raw code.
  // }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    // Full-height, non-scrolling 50/50 split — matches the layout you
    // wanted. If content ever overflows on a small phone, wrap this Column
    // in a SingleChildScrollView; for two sections this size it shouldn't.
    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Top dark header with logo ----------
            Container(
              width: double.infinity,
              height: 470,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Kept the app's existing purple brand gradient (same one
                  // SignInScreen uses) instead of the steel-blue colors from
                  // your pasted snippet, so both screens stay visually
                  // consistent. Swap these two hex values if you actually
                  // wanted the blue-gray look on purpose.
                  colors: [Color(0xFF1B1330), Color(0xFF120C24)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LogoBadge(),
                  const SizedBox(height: 20),
                  const Text(
                    'ALFASUN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'POINT OF SALE',
                    style: TextStyle(
                      color: Color(0xFF8D8AA3),
                      fontSize: 12,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Bottom white sheet ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
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
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: colors.border,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Text(
                    'Enter Store Code',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Each mart has a unique 4-digit code',
                    style: TextStyle(fontSize: 14, color: colors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Store Code',
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StoreCodeField(controller: _storeCodeController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        disabledBackgroundColor: AppColors.textWhite,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),

                      child: const Text(
                        'Connect to Store',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 140),
                  Center(
                    child: Text(
                      'Made with ❤️ by Alfasun',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
                      ),
                    ),
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

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: AppImage.asset('assets/alfasun_Logo.jpeg', fit: BoxFit.cover),
      ),
    );
  }
}
