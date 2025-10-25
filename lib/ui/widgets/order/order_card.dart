import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/model/order/order_model.dart';
import 'package:smart_city/core/provider/order_provider.dart';
import 'package:smart_city/ui/widgets/image/custom_network_image.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/constants/image_assets.dart';
import '../../../utils/extensions/build_context_extension.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order,});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, provider, _) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Card(
            color: Colors.white,
            child: Column(
              children: [
                CustomNetworkImage(
                  imagePath: order.shopDetails.image,
                  fit: BoxFit.fill,
                  height: 100,
                  width: double.maxFinite,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            order.shopDetails.shopName,
                            style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Order Date:  ',
                            style: AppTypography.bodyMedium,

                          ),
                          Text(order.orderdate)
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Order Id:  ',
                            style: AppTypography.bodyMedium,

                          ),
                          Text(order.id)
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          order.amount.toString(),
                          style: AppTypography.bodyLarge.copyWith(
                              color: const Color(0xFFC6011F),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
