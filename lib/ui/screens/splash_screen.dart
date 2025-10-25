import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/image_assets.dart';
import '../../core/injection/injection.dart';
import '../../core/provider/auth_provider.dart';

@RoutePage()
class SplashScreen extends StatelessWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<AuthProvider>(),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    _next(context);
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      body: Center(
        child: Image.asset(
          ImageAssets.logo,
        ),
      ),
    );
  }
}

Future<void> _next(BuildContext context) async {
  await Future.delayed(
    const Duration(seconds: 3),
  );
  if (context.mounted) {
    await context.read<AuthProvider>().startApp();
  }
}
