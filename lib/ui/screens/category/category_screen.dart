import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/provider/shop_provider.dart';

import '../../../core/injection/injection.dart';
import '../../widgets/category_card/category_card.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/null/null_card.dart';


@RoutePage()
class CategoryScreen extends StatefulWidget implements AutoRouteWrapper{
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();

  @override
  Widget wrappedRoute(BuildContext context)=> ChangeNotifierProvider(create: (context) => locator<ShopProvider>()..getCategory(), child: this,);
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "SMART CITY",
          style: AppTypography.titleLarge.copyWith(
              color: AppColors.buttonColor),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.blue.shade100,
        elevation: 3,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(CupertinoIcons.left_chevron),
          onPressed: () => context.router.maybePop(),),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Gap(AppDimensions.gapRegular),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Categories',
                        style: AppTypography.titleSmall.copyWith(
                            color: AppColors.buttonColor
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<ShopProvider>(
                  builder: (context, provider,_) {
                    if (!provider.isBusy && provider.categories.isEmpty) {
                      return NullCard();
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
                      childAspectRatio: 1,
                      shrinkWrap: true,
                      children: List.generate(
                        provider.isBusy && provider.shops.isEmpty
                          ? 16
                          : provider.categories.length,
                            (index) => CategoryCard(
                                isLoading: provider.isBusy && provider.shops.isEmpty,
                                category: !provider.isBusy && provider.categories.isNotEmpty ? provider.categories[index] : null,

                            ),
                      ),
                    );
                  }
                ),
              ),
            ],
          )
      ),
    );
  }
}
