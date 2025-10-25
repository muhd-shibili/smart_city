import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/ui/widgets/buttons/favourite_button.dart';
import 'package:smart_city/utils/helper/debounce_helper.dart';

import '../../../core/injection/injection.dart';
import '../../../core/model/banner/banner_model.dart';
import '../../../core/model/shop/shop_model.dart';
import '../../../core/provider/product_provider.dart';
import '../../../core/provider/shop_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimensions.dart';
import '../../../utils/constants/app_typography.dart';
import '../../../utils/extensions/build_context_extension.dart';
import '../../widgets/buttons/ink_well_material.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/shop_card/offer_card.dart';
import '../../widgets/textfield/secondary_textfield.dart';

@RoutePage()
class ProductScreen extends StatefulWidget implements AutoRouteWrapper {
  final ShopModel shop;

  const ProductScreen({super.key, required this.shop});

  @override
  State<ProductScreen> createState() => _ProductScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => locator<ProductProvider>(),
          ),
          ChangeNotifierProvider(
            create: (context) => locator<ShopProvider>(),
          ),
        ],
        child: this,
      );
}

class _ProductScreenState extends State<ProductScreen> {
  late ValueNotifier<bool> _isFavorite;
  final TextEditingController _search = TextEditingController();
  final DebounceHelper _debounceHelper = DebounceHelper();

  @override
  void initState() {
    super.initState();
    _isFavorite = ValueNotifier(widget.shop.isFavorite);
    Future.microtask(
      () => _getData(),
    );
  }

  Future<void> _getData() async {
    await Future.value([
      context.read<ShopProvider>().getShopDetails(widget.shop.id),
      context.read<ProductProvider>().getStoreProduct(widget.shop.id, _search.text),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductProvider>(builder: (context, provider, _) {
          List<BannerModel> banners = [];
          banners.add(
            BannerModel(
                id: widget.shop.id,
                shop: widget.shop.shopName,
                image: widget.shop.image),
          );
          banners.addAll(provider.banners);
          return RefreshIndicator(
            onRefresh: _getData,
            child: Column(
              children: [
                const Gap(AppDimensions.gapRegular),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.screenPadding),
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
                SizedBox(
                  width: 373,
                  height: 52,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.screenPadding),
                    child: SecondaryTextField(
                      controller: _search,
                      hintText: 'Search Products',
                      onChanged: (value) => _debounceHelper.run(() => _getData(),),
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        const Gap(AppDimensions.gapRegular),
                        CarouselSlider.builder(
                          itemCount: banners.length,
                          itemBuilder: (context, index, realIndex) => OfferCard(
                            bannerModel: banners[index],
                          ),
                          options: CarouselOptions(
                            aspectRatio: 3,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                        ),
                        const Gap(AppDimensions.gapRegular),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenPadding),
                          child: Consumer<ShopProvider>(
                            builder: (context, shopProvider, _) {
                              if(shopProvider.shopDetails != null) {
                                  _isFavorite.value = shopProvider.shopDetails!.isFavorite;
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          shopProvider.shopDetails?.shopName ?? widget.shop.shopName,
                                          style: AppTypography.titleSmall.copyWith(
                                            color: AppColors.buttonColor,
                                            fontWeight: AppTypography.weightBold,
                                          ),
                                        ),
                                      ),
                                      Selector<ShopProvider, bool>(
                                          selector: (context, provider) =>
                                              provider.isFavoriteLoading,
                                          builder: (context, isFavoriteLoading, _) {
                                            return FavouriteButton(shop: shopProvider.shopDetails ?? widget.shop, isBusy: isFavoriteLoading);
                                          }),
                                    ],
                                  ),
                                  Text(
                                    widget.shop.shopDescription,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              );
                            }
                          ),
                        ),
                        const Gap(AppDimensions.gapRegular),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.screenPadding),
                          child: ListView.builder(
                            itemCount: provider.products.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ProductCard(
                                product: provider.products[index],
                              ),
                            ),
                          ),
                        ),
                        // const Gap(AppDimensions.gapSmall),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> _updateFavoriteStatus() async {
    final result = await context
        .read<ShopProvider>()
        .addRemoveFavouriteStores(widget.shop.id);
      _isFavorite.value = result ? !_isFavorite.value : _isFavorite.value;
  }
}
