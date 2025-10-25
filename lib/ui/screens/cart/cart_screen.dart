import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/ui/widgets/null/null_card.dart';

import '../../../core/injection/injection.dart';
import '../../../core/provider/cart_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/cart_card/cart_card.dart';
import '../../widgets/payment/payment_details.dart';

@RoutePage()
class CartScreen extends StatefulWidget implements AutoRouteWrapper {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider.value(
        value: locator<CartProvider>(),
        child: this,
      );
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getData);
  }

  Future<void> _getData() async {
    Future.value([
      context.read<CartProvider>().getCart(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style:
              AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.left_chevron),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, provider, child) {
            if (provider.isBusy && (provider.cart?.cartItems.isEmpty ?? true)) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (!provider.isBusy &&
                (provider.cart?.cartItems.isEmpty ?? true)) {
              return const NullCard();
            }
            return RefreshIndicator(
              displacement: 50,
              onRefresh: _getData,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: context.screenPadding),
                      itemCount: provider.cart?.cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          CartCard(product: provider.cart!.cartItems[index]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.screenPadding),
                      child: PaymentDetails(
                        discount: provider.cart?.discount ?? 0,
                        payableAmount: provider.cart?.grandTotalWithTax ?? 0,
                        subTotal: provider.cart?.subtotal ?? 0,
                        tax: provider.cart?.tax ?? 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.screenPadding),
                      child: InkWellMaterial(
                        onTap: () async {
                          final orderId = await context.read<CartProvider>().placeOrder();
                          if(context.mounted && orderId != null){
                            await context.router.replace(ConfirmRoute(orderId: orderId));
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6011F),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: provider.placeOrderLoading
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    "Buy Now",
                                    style: AppTypography.labelLarge
                                        .copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Gap(MediaQuery.paddingOf(context).bottom + 120),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
