import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ink_well_material.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellMaterial(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(15)),
        child: isLoading ? const CupertinoActivityIndicator(color: Colors.white,) :Text(
          text,
          style: AppTypography.titleSmall.copyWith(
            color: AppColors.primaryBg,
            fontWeight: AppTypography.weightBold,
          ),
        ),
      ),
    );
  }
}
