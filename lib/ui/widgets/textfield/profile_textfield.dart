import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';

class ProfileTextFeild extends StatefulWidget {
  ProfileTextFeild(
      {super.key, this.initVal, required this.lbel, required this.passHide});

  String? initVal;
  final String lbel;
  bool passHide = true;

  @override
  State<ProfileTextFeild> createState() => _ProfileTextFeildState();
}

class _ProfileTextFeildState extends State<ProfileTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTypography.labelLarge,
      initialValue: widget.initVal,
      obscureText: widget.passHide,
      decoration: InputDecoration(
          label: Text(
            widget.lbel,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.buttonColor))),
    );
  }
}
