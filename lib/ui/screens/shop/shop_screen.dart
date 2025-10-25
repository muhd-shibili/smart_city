import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/model/category/category_model.dart';
import '../../../core/model/shop/shop_model.dart';
import '../../../core/provider/shop_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../../utils/helper/debounce_helper.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/null/null_card.dart';
import '../../widgets/shop_card/shop_card.dart';
import '../../widgets/textfield/secondary_textfield.dart';

@RoutePage()
class ShopScreen extends StatefulWidget implements AutoRouteWrapper {
  final CategoryModel? category;

  const ShopScreen({super.key, this.category});

  @override
  State<ShopScreen> createState() => _ShopScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider(
    create: (context) =>
    locator<ShopProvider>()..getShops(categoryId: category?.id),
    child: this,
  );

}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DebounceHelper _debounceHelper = DebounceHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        displacement: 100,
        onRefresh: () => _getData(context),
        child: Column(
          children: [
            const Gap(AppDimensions.gapRegular),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
              child: Row(
                children: [
                  InkWellMaterial(
                    onTap: () => context.router.maybePop(),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 30,
                    ),
                  ),
                  const Gap(AppTypography.sTitleSmall),
                  Text(
                    'SMART CITY',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.buttonColor,
                      fontWeight: AppTypography.weightBold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppDimensions.gapRegular),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.screenPadding),
                child: SecondaryTextField(
                  hintText: 'Search Shops',
                  icon: Icon(Icons.search),
                  controller: _searchController,
                  onChanged: (value) => _debounceHelper.run(() => _getData(context),),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.category?.categoryName ?? 'Shops',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ShopProvider>(
                builder: (context, provider, _) {
                  if (!provider.isBusy && provider.shops.isEmpty) {
                    return const NullCard();
                  }

                  return GridView.count(
                    primary: false,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.61,
                    shrinkWrap: true,
                    children: List.generate(
                      provider.isBusy && provider.shops.isEmpty
                          ? 16
                          : provider.shops.length,
                      (index) => ShopCard(
                        isLoading: provider.isBusy && provider.shops.isEmpty,
                        shopModel: provider.isBusy && provider.shops.isEmpty
                            ? const ShopModel(
                                id: 'id',
                                shopName: 'shopName',
                                shopDescription: 'shopDescription',
                                ownerName: 'ownerName',
                                image: 'image',
                                location: 'location',
                                contactNumber: 'contactNumber',
                              )
                            : provider.shops[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _getData(BuildContext context) =>
      context.read<ShopProvider>().getShops(
            categoryId: widget.category?.id,

          );
}
