import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/injection/injection.dart';

import '../../../core/provider/order_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/order/order_card.dart';

@RoutePage()
class OrdersScreen extends StatefulWidget implements AutoRouteWrapper {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider(
        create: (context) => locator<OrderProvider>(),
        child: this,
      );
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    Future.microtask(_getData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Orders",
          style:
              AppTypography.titleLarge.copyWith(color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.screenPadding,
              vertical: context.screenPadding),
          child: Column(
            children: [
              Consumer<OrderProvider>(builder: (context, provider, _) {
                return ListView.builder(
                  itemCount: provider.orders.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWellMaterial(
                        onTap: () {
                          context.router.push(
                            OrderDetailsRoute(
                              orderId: provider.orders[index].id,
                            ),
                          );
                        },
                        child: OrderCard(
                          order: provider.orders[index],
                        )),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    context.read<OrderProvider>().getAllOrders();
  }
}
