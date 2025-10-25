import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';

@RoutePage()
class ConfirmScreen extends StatelessWidget {
  final String orderId;

  const ConfirmScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    _next(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: context.screenPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 110,
                ),
                Text(
                  "Order Placed",
                  style: AppTypography.headlineLarge.copyWith(
                    color: Colors.black,
                    fontWeight: AppTypography.weightBold,
                  ),
                ),
                Text(
                  'order id: $orderId',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.primaryBg,
                    fontWeight: AppTypography.weightBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _next(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (context.mounted) {
      await context.router.replace(OrderDetailsRoute(orderId: orderId));
    }
  }
}