// import 'package:alfasun_pos/Common/app_image.dart';
// import 'package:alfasun_pos/Screens/LogIn/auth_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../theme/app_colors.dart';
// import 'pin_entry_screen.dart';

// /// This is a ConsumerWidget — the Riverpod version of StatelessWidget.
// /// The only difference from a normal StatelessWidget is the extra `ref`
// /// parameter in build(), which lets you talk to providers.
// class RoleSelectionScreen extends ConsumerWidget {
//   const RoleSelectionScreen({super.key});

//   void _selectRole(BuildContext context, WidgetRef ref, UserRole role) {
//     // ref.read(...).state = ... updates the StateProvider's value.
//     // Use .read() (not .watch()) inside callbacks like onTap — .watch() is
//     // only for the build() method, where you want the widget to rebuild.
//     ref.read(selectedRoleProvider.notifier).state = role;

//     Navigator.of(
//       context,
//     ).push(MaterialPageRoute(builder: (_) => const PinEntryScreen()));
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: Color(
//         0xFF29323c,
//       ), // dark gradient background behind the white sheet
//       body: Column(
//         children: [
//           // ---------- Top dark header with logo ----------
//           Expanded(
//             flex: 5,
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFF485563), Color(0xFF29323c)],
//                 ),
//               ),
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _LogoBadge(),
//                   SizedBox(height: 20),
//                   Text(
//                     'ALFASUN',
//                     style: TextStyle(
//                       color: AppColors.textWhite,
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'POINT OF SALE',
//                     style: TextStyle(
//                       color: AppColors.textGrey,
//                       fontSize: 12,
//                       letterSpacing: 3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ---------- Bottom white sheet ----------
//           Expanded(
//             flex: 5,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
//               decoration: const BoxDecoration(
//                 color: AppColors.sheetBackground,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // little drag handle like in your design
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       margin: const EdgeInsets.only(bottom: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ),
//                   const Text(
//                     'Welcome back',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Select your role to continue',
//                     style: TextStyle(fontSize: 14, color: AppColors.textGrey),
//                   ),
//                   const SizedBox(height: 24),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: _RoleCard(
//                           icon: Icons.shopping_cart_outlined,
//                           title: 'Cashier',
//                           subtitle: 'Sales & transactions',
//                           onTap: () =>
//                               _selectRole(context, ref, UserRole.cashier),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: _RoleCard(
//                           icon: Icons.grid_view_rounded,
//                           title: 'Manager',
//                           subtitle: 'Full access & reports',
//                           onTap: () =>
//                               _selectRole(context, ref, UserRole.manager),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const Spacer(),

//                   // Demo PIN hint box
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.cardBackground,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "Made with ❤️ by Alfasun",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: AppColors.textGrey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _LogoBadge extends StatelessWidget {
//   const _LogoBadge();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 64,
//       height: 64,
//       decoration: BoxDecoration(
//         color: AppColors.primaryPurple,
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: AppImage.asset('assets/alfasun_Logo.jpeg', fit: BoxFit.cover),
//       ),
//     );
//   }
// }

// class _RoleCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;

//   const _RoleCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryPurple,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: Colors.white, size: 20),
//             ),
//             const SizedBox(height: 14),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: AppColors.textDark,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               subtitle,
//               style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
