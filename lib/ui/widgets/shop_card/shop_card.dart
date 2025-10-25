import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_city/core/model/shop/shop_model.dart';
import 'package:smart_city/core/routes/app_router.gr.dart';
import 'package:smart_city/ui/widgets/buttons/ink_well_material.dart';
import 'package:smart_city/ui/widgets/image/custom_network_image.dart';
import 'package:smart_city/ui/widgets/shimmer/shimmer_list_loading.dart';

import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';

class ShopCard extends StatelessWidget {
  final bool isLoading;

  const ShopCard({super.key, required this.shopModel, this.isLoading = false});

  final ShopModel shopModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWellMaterial(
        onTap: () => context.router.push(ProductRoute(shop: shopModel)),
        child: Card(
          color: Colors.white,
          shadowColor: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLoading)
                const Expanded(
                  child: ShimmerListLoading(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                )
              else ...[
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CustomNetworkImage(
                      imagePath: shopModel.image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                    ),
                  ),
                ),
                const Gap(AppDimensions.gapSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    shopModel.shopName,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(AppDimensions.gapSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    shopModel.shopDescription,
                    textAlign: TextAlign.start,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(AppDimensions.gapSmall),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
