import 'package:flutter/material.dart';
import '../../../utils/constants/app_typography.dart';

class RegTextField extends StatefulWidget {
  final String hntext;
  final String lbtext;
  final Widget? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;


   const RegTextField({
    super.key,
    required this.hntext,
    required this.lbtext,
    this.icon,
    this.isPassword = false, this.controller, this.validator,
  });

  @override
  State<RegTextField> createState() => _RegTextFieldState();
}


class _RegTextFieldState extends State<RegTextField> {
  bool _isSecure = false;

  @override
  void initState() {
    super.initState();
    _isSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        fontFamily: AppTypography.defaultFamily,
      ),
      obscureText: _isSecure,
      decoration: InputDecoration(
        hintText: widget.hntext,
        labelText: widget.lbtext,
        // fillColor: Color(0x8BD9D0C8),
        fillColor: Color(0x18777B7C),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintStyle: TextStyle(fontSize: 15, color: Color(0x621A1A1D)),
        labelStyle: AppTypography.labelMedium,
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(
                  () => _isSecure = !_isSecure,
                ),
                icon: Icon(
                  _isSecure ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}


