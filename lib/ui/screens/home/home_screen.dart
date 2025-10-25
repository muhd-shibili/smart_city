import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


import '../../widgets/shimmer/shimmer_list_loading.dart';
import '../../widgets/image/custom_network_image.dart';
import '../../../core/injection/injection.dart';
import '../../../core/model/category/category_model.dart';
import '../../../core/provider/home_provider.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/shop_card/offer_card.dart';
import '../../widgets/shop_card/shop_card.dart';
import '../../widgets/textfield/secondary_textfield.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider(create: (context) => locator<HomeProvider>(), child: this,);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // resizeToAvoidBottomInset: f,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return RefreshIndicator(
              displacement: 100,
              onRefresh: _getData,
              child: Column(
                children: [
                  const Gap(AppDimensions.gapRegular),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
                    child: Row(
                      children: [
                        // Gap(AppTypography.sTitleSmall),
                        Text(
                          'SMART CITY',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.buttonColor,
                            fontWeight: AppTypography.weightBold,
                          ),
                        ),
                        const Gap(AppDimensions.gapSmall),
                        const Spacer(),
                        // const SizedBox(
                        //   width: 113,
                        //   height: 32,
                        //   child: SecondaryTextField(
                        //     hintText: "Location",
                        //     icon: Icon(Icons.location_on),
                        //     // lbtext: "location",
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const Gap(AppDimensions.gapRegular),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(AppDimensions.gapRegular),
                          // Gap(AppDimensions.gapMedium),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.screenPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWellMaterial(
                                  onTap: () {
                                    context.router.push(const CategoryRoute());
                                  },
                                  child: Text(
                                      'Category List',
                                      style: AppTypography.titleSmall
                                          .copyWith(color: AppColors.buttonColor)),
                                ),
                                InkWellMaterial(
                                  onTap: () {
                                    context.router.push(const CategoryRoute());
                                  },
                                  child: Text('View More',
                                      style: AppTypography.bodyMedium
                                          .copyWith(color: AppColors.buttonColor)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemCount: provider.categories.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: context.screenPadding),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    right: index == (provider.categories.length -1) ? context.screenPadding : 8.0,
                                    left: index == (provider.categories.length -1) ? context.screenPadding : 0),
                                child: _CategoryCard(category: provider.categories[index],),
                              ),
                            ),
                          ),
                          const Gap(AppDimensions.gapSmall),
                          CarouselSlider.builder(
                              itemCount: provider.banners.length,
                              itemBuilder: (context, index, realIndex) {
                                if(provider.banners.isEmpty){
                                  return ShimmerListLoading(height: 50, width: 250);
                                }
                               return  OfferCard(bannerModel: provider.banners[index],);
                              },

                              options: CarouselOptions(
                                aspectRatio: 3,
                                autoPlay: true,
                                enlargeCenterPage: true,
                              )),
                          const Gap(AppDimensions.gapRegular),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.screenPadding),
                            child: Text(
                                'Featured Stores',
                                style: AppTypography.titleSmall
                                    .copyWith(color: AppColors.buttonColor)),
                          ),
                          GridView.count(
                            primary: false,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 0.61,
                            shrinkWrap: true,
                            children: List.generate(
                              provider.shops.length,
                              (index) => ShopCard(shopModel: provider.shops[index],),
                            ),
                          ),
                          Gap(context.safeBottom)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> _getData() async {
    Future.value([
      context.read<HomeProvider>().getHome(),
    ]);
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWellMaterial(
      onTap: () => context.router.push(ShopRoute(category: category)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
          ClipOval(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CustomNetworkImage(
                imagePath: category.image,
                fit: BoxFit.cover,
                height: context.reactiveWidth(
                  ratio: 0.16,
                  lowerLimit: 52,
                  upperLimit: 64,
                ),
                width: context.reactiveWidth(
                  ratio: 0.16,
                  lowerLimit: 52,
                  upperLimit: 64,
                ),
              ),
            ),
          ),
          const Gap(AppDimensions.gapSmall),
          Text(
            category.categoryName,
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
