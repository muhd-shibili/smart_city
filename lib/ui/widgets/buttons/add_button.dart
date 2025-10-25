import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/model/cart/cart_model.dart';
import 'package:smart_city/core/model/product/product_model.dart';
import 'package:smart_city/ui/modals/add_to_cart_modal.dart';
import 'package:smart_city/ui/modals/custom_modal.dart';
import 'package:smart_city/ui/widgets/buttons/ink_well_material.dart';

import '../../../core/injection/injection.dart';
import '../../../core/provider/cart_provider.dart';
import '../../../utils/constants/app_typography.dart';

class AddButton extends StatelessWidget implements AutoRouteWrapper{
  final ProductModel product;

  const AddButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWellMaterial(
      onTap: () => _showAddToCartModal(context),
      child: Selector<CartProvider, CartModel?>(
        selector: (p0, p1) => p1.cart,
        builder: (context, cart, _) {
          final hasProducts = cart?.cartItems.any((element) => element.id == product.id,) ?? false ;
          return Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
                color: const Color(0xFFC6011F),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasProducts ? Icons.add_shopping_cart_outlined : Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
                Text(
                  hasProducts ?'Edit' : "Add",
                  style: AppTypography.labelMedium.copyWith(color: Colors.white),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  void _showAddToCartModal(BuildContext context) {
    CustomModal.showBottomModal(
      routeName: 'add-to-cart-modal',
      context: context,
      builder: (context) => AddToCartModal(product: product,),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
    value: locator<CartProvider>(),
    child: this,
  );

}
