import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_city/core/model/product/product_model.dart';
import 'package:smart_city/ui/widgets/image/custom_network_image.dart';

import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../buttons/add_button.dart';

class OrderProductCard extends StatelessWidget {

  final ProductModel product;

  const OrderProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: context.reactiveWidth(
                ratio: 0.27,
                lowerLimit: 80,
                upperLimit: 100,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, left: 4),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: CustomNetworkImage(
                    imagePath: product.image,
                    height: 124,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Text(
                      product.productName,
                      style: AppTypography.bodyLarge
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const Gap(10),
                    Text(
                      product.description,
                      softWrap: true,
                      style:
                      AppTypography.bodySmall.copyWith(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee,
                              color: Colors.red,
                              size: 15,
                            ),
                            Text(product.price,
                                style: AppTypography.bodyLarge.copyWith(
                                    color: Colors.red,
                                    fontWeight: AppTypography.weightBold,
                                    fontSize: 18)),
                            const Gap(10),
                            const Icon(
                              Icons.currency_rupee,
                              size: 15,
                            ),
                            Text(
                              product.mrp,
                              style: AppTypography.bodyMedium.copyWith(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        const Text('Item Count:'),
                        const Gap(10),
                        Text(product.quantity.toString())
                      ],
                    )
                    // const Gap(10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
