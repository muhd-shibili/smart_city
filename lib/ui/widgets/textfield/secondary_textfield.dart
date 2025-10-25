import 'package:flutter/material.dart';

import '../../../utils/constants/app_typography.dart';

class SecondaryTextField extends StatelessWidget {
  final Widget? icon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SecondaryTextField({
    super.key,
    this.icon,
    this.hintText,
    this.keyboardType, this.controller, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) => onChanged?.call(value),
      style: const TextStyle(
        fontFamily: AppTypography.defaultFamily,
        fontSize: AppTypography.sBodySmall,
      ),
      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(4),
        // labelText: lbtext,
        fillColor: const Color(0x18777B7C),
        // fillColor: Color(0x42D8D8D8),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        hintStyle: const TextStyle(
            fontSize: AppTypography.sLabelSmall, color: Color(0x621A1A1D)),
        labelStyle: AppTypography.labelMedium,
        prefixIcon: icon,
      ),
    );
  }
}
