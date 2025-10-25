import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/model/product/product_model.dart';
import '../../../core/provider/order_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/order/order_product_card.dart';
import '../../widgets/payment/payment_details.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget implements AutoRouteWrapper {
  final String orderId;
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Order Details",
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
        child: Consumer<OrderProvider>(builder: (context, provider, child) {
          if (provider.isBusy) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return RefreshIndicator(
            displacement: 50,
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: context.screenPadding),
                    itemCount: provider.orderDetail?.cartItems.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => OrderProductCard(
                      // hasProducts: provider.cart?.cartItems.isNotEmpty ?? false,
                      product: provider.orderDetail?.cartItems[index] ??
                          const ProductModel(
                              image: 'image',
                              productName: 'productName',
                              id: 'saf',
                              description: 'description'),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.screenPadding),
                    child: PaymentDetails(
                      discount: provider.orderDetail?.discount ?? 0,
                      payableAmount:
                          provider.orderDetail?.grandTotalWithTax ?? 0,
                      subTotal: provider.orderDetail?.subtotal ?? 0,
                      tax: provider.orderDetail?.tax ?? 0,
                    ),
                  ),
                  Gap(MediaQuery.paddingOf(context).bottom + 10),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider(
        create: (context) =>
            locator<OrderProvider>()..getOrderDetails(orderId: orderId),
        child: this,
      );
}
