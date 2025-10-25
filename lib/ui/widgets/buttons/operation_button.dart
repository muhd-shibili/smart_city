import 'package:flutter/material.dart';

import '../../../utils/constants/app_typography.dart';

class OperationButton extends StatefulWidget {
  OperationButton({super.key, required this.btnTxt});

  final String btnTxt;

  @override
  State<OperationButton> createState() => _OperationButtonState();
}

class _OperationButtonState extends State<OperationButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          widget.btnTxt,
          style:
          AppTypography.labelLarge.copyWith(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFC6011F),
            borderRadius: BorderRadius.circular(15),
           ),
        );
    }
}