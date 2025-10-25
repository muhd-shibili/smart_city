import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:smart_city/utils/extensions/build_context_extension.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../widgets/buttons/ink_well_material.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notification",
          style: AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(CupertinoIcons.left_chevron),onPressed: () => context.router.maybePop(),),
      ),
    );
  }
}
