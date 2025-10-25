import 'package:flutter/material.dart';

import '../../utils/extensions/build_context_extension.dart';
import '../../utils/constants/app_colors.dart';

abstract class CustomModal {
  static void showBottomModal({
    required String routeName,
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
    bool isScrollControlled = false,
    Color backgroundColor = AppColors.primaryBg,
    BoxConstraints? constraints,
    bool isDismissible = true,
  }) =>
      showModalBottomSheet(
        isDismissible: isDismissible,
        routeSettings: RouteSettings(name: routeName),
        context: context,
        elevation: 0,
        isScrollControlled: true,
        constraints: constraints ?? BoxConstraints(
          maxHeight: context.height * 0.9,
          minHeight: 100,
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        enableDrag: true,
        useRootNavigator: true,
        // useSafeArea: true,
        backgroundColor: backgroundColor,
        builder: (context) => DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.primaryBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: builder(context),
          ),
        ),
      );
}