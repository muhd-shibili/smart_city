import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/injection/injection.dart';
import 'package:smart_city/core/provider/cart_provider.dart';
import 'package:smart_city/ui/modals/add_to_cart_modal.dart';
import 'package:smart_city/utils/extensions/build_context_extension.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_dimensions.dart';
import '../../utils/constants/app_typography.dart';
import '../widgets/buttons/ink_well_material.dart';

class ClearCartModal extends StatelessWidget implements AutoRouteWrapper {
  const ClearCartModal({super.key, required this.onSubmit, required this.onCancel});

  final AsyncCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Do you want to clear the cart?',
                style: AppTypography.bodyMedium,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWellMaterial(
                  onTap: onCancel,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC6011F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Remove',
                        style: AppTypography.labelLarge
                            .copyWith(color: AppColors.primaryBg),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(AppDimensions.gapRegular),
              Expanded(
                child: Selector<CartProvider, bool>(
                    selector: (p0, p1) => p1.isBusy,
                    builder: (context, value, child) {
                      return InkWellMaterial(
                        onTap: () async {
                          final result = await context.read<CartProvider>().clearCart();
                          if(context.mounted && result) {
                            await onSubmit.call();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6011F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: value
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    'Add',
                                    style: AppTypography.labelLarge
                                        .copyWith(color: AppColors.primaryBg),
                                  ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
           Gap(context.safeBottomStrict + 20),
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<CartProvider>(),
        child: this,
      );
}
