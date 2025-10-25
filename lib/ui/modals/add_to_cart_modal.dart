import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/ui/modals/clear_cart_modal.dart';

import '../../core/injection/injection.dart';
import '../../core/model/product/product_model.dart';
import '../../core/provider/cart_provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_dimensions.dart';
import '../../utils/constants/app_typography.dart';
import '../../utils/extensions/build_context_extension.dart';
import '../../utils/helper/debounce_helper.dart';
import '../../utils/snack_bar/snack_bar_alert.dart';
import '../widgets/buttons/ink_well_material.dart';
import '../widgets/image/custom_network_image.dart';
import '../widgets/textfield/secondary_textfield.dart';
import 'custom_modal.dart';

class AddToCartModal extends StatefulWidget implements AutoRouteWrapper {
  final ProductModel product;

  const AddToCartModal({super.key, required this.product});

  @override
  State<AddToCartModal> createState() => _AddToCartModalState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<CartProvider>(),
        child: this,
      );
}

class _AddToCartModalState extends State<AddToCartModal> {
  late final TextEditingController _productCountController;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isRemoveLoading = ValueNotifier(false);
  final DebounceHelper _debounceHelper = DebounceHelper();

  @override
  void initState() {
    _productCountController = TextEditingController();
    _getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: context.screenPadding,
          right: context.screenPadding,
          bottom: context.bottomInsets + 30,
        ),
        child: Column(
          children: [
            const Gap(AppDimensions.gapXXL),
            CustomNetworkImage(
                imagePath: widget.product.image, height: 150, width: 200),
            Text(
              widget.product.productName,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(widget.product.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₹${widget.product.price}',
                  style: AppTypography.bodyLarge.copyWith(
                      color: Colors.red,
                      fontWeight: AppTypography.weightBold,
                      fontSize: 25),
                ),
                const Gap(AppDimensions.gapRegular),
                Text(
                  '₹${widget.product.mrp}',
                  style: AppTypography.bodyMedium.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 18),
                ),
                const Gap(AppDimensions.gapRegular),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count:',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Container(),
                SizedBox(
                  width: 100,
                  child: SecondaryTextField(
                    controller: _productCountController,
                    onChanged: (value) =>
                        _debounceHelper.run(() => _onCountChange(value)),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            const Gap(AppDimensions.gapRegular),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWellMaterial(
                  onTap: _removeTap,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC6011F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder(
                        valueListenable: _isRemoveLoading,
                        builder: (context, value, _) {
                          return Center(
                            child: value
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    'Remove',
                                    style: AppTypography.labelLarge
                                        .copyWith(color: AppColors.primaryBg),
                                  ),
                          );
                        }),
                  ),
                ),
                const Gap(AppDimensions.gapRegular),
                ValueListenableBuilder(
                    valueListenable: _isLoading,
                    builder: (context, value, child) {
                      return InkWellMaterial(
                        onTap: _addToCart,
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6011F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: value
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    'Done',
                                    style: AppTypography.labelLarge
                                        .copyWith(color: AppColors.primaryBg),
                                  ),
                          ),
                        ),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isLoading.dispose();
    _productCountController.dispose();
    super.dispose();
  }

  void _getCount() {
    final cart = context.read<CartProvider>().cart;
    _productCountController.text = cart?.cartItems
            .firstWhereOrNull(
              (element) => element.id == widget.product.id,
            )
            ?.quantity
            .toString() ??
        '0';
  }

  void _onCountChange(String value) {
    final v = int.tryParse(value) ?? 0;
    if (v > 50) {
      locator<SnackBarAlert>()
          .showToast(message: 'Count can\'t be greater than 50');
    } else if (v <= 0) {
      locator<SnackBarAlert>()
          .showToast(message: 'Count can\'t be less than 1');
    }
  }

  Future<void> _removeTap() async {
    _isRemoveLoading.value = true;
    try {
      await context.read<CartProvider>().removeFromCart(productId: widget.product.id);
    } finally {
      _isRemoveLoading.value = false;
    }
    if(mounted) {
      await context.router.maybePop();
    }
  }

  Future<void> _addToCart() async {
    if(widget.product.storeId != context.read<CartProvider>().cart?.storeId){
      CustomModal.showBottomModal(
        routeName: 'add-to-cart-modal',
        context: context,
        builder: (context) => ClearCartModal(onCancel: () => context.router.popForced(), onSubmit: () async {
          await context.router.maybePop();
          if(context.mounted){
            await _updateTap();
          }
        },),
      );

    } else {
      await _updateTap();
    }

  }

  Future<void> _updateTap() async {
    if (_productCountController.text == '0') {
      return locator<SnackBarAlert>()
          .showToast(message: 'Count must be at least 1');
    }
    _isLoading.value = true;

    try {
      await context.read<CartProvider>().updateProductCount(
            productId: widget.product.id,
            shopId: widget.product.storeId,
            quantity: _productCountController.text,
          );
    } finally {
      _isLoading.value = false;
      if (mounted) {
        context.router.maybePop();
      }
    }
  }
}
