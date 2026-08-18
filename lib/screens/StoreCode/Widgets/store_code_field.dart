import 'package:alfasun_pos/theme/app_color_scheme.dart';
import 'package:alfasun_pos/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoreCodeField extends StatelessWidget {
  final TextEditingController controller;
  // final ValueChanged<String> onChanged;

  const StoreCodeField({
    super.key,
    required this.controller,
    // required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return TextField(
      controller: controller,
      // onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        color: AppColors.textDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 4,
      ),
      decoration: InputDecoration(
        hintText: 'e.g. 1001',
        hintStyle: TextStyle(
          color: colors.textSecondary,
          fontSize: 15,
          letterSpacing: 4,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Text(
            '#',
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: AppColors.textWhite,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}
