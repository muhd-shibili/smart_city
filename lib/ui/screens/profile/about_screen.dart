import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      appBar: AppBar(
        title: Text(
          "About us",
          style: AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(CupertinoIcons.left_chevron),onPressed: () => context.router.maybePop(),),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SMART CITY',
              style: AppTypography.titleLarge.copyWith(color: Colors.white),
            ),
            Text(
              'The New Normal Shopping',
              style: AppTypography.bodyMedium.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
