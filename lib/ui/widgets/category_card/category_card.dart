import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_city/core/model/category/category_model.dart';
import 'package:smart_city/ui/widgets/shimmer/shimmer_list_loading.dart';

import '../../../core/routes/app_router.gr.dart';
import '../buttons/ink_well_material.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/constants/image_assets.dart';
import '../image/custom_network_image.dart';

class CategoryCard extends StatelessWidget {
  final bool isLoading;
  final CategoryModel? category;

  const CategoryCard({super.key, this.isLoading = false, this.category});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWellMaterial(
        onTap: () => context.router.push(ShopRoute(category: category,)),
        child: Card(
          color: Colors.white,
          shadowColor: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLoading || category == null)
                const Expanded(
                  child: ShimmerListLoading(
                      height: double.infinity, width: double.infinity),
                )
              else ...[
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CustomNetworkImage(imagePath: category!.image,),
                  ),
                ),
                const Gap(AppDimensions.gapSmall),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    category!.categoryName,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium,
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
