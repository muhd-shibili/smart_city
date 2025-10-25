import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/model/shop/shop_model.dart';
import '../../../core/provider/shop_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_typography.dart';
import '../../widgets/null/null_card.dart';
import '../../widgets/shop_card/shop_card.dart';

@RoutePage()
class FavouriteScreen extends StatefulWidget implements AutoRouteWrapper{
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();

  @override
  Widget wrappedRoute(BuildContext context) => ChangeNotifierProvider(
    create: (context) =>
    locator<ShopProvider>()..getFavouriteStore(),
    child: this,
  );
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Favourite Stores",
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
          child: Consumer<ShopProvider>(
            builder: (context, provider, _) {
              if (!provider.isBusy && provider.shops.isEmpty) {
                return NullCard();
              }
              return Consumer<ShopProvider>(
                builder: (context, provider, _) {
                  if (!provider.isBusy && provider.shops.isEmpty) {
                    return NullCard();
                  }
                  return GridView.count(
                    primary: false,
                    physics: const BouncingScrollPhysics(),
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
                }
              );
            }
          )),
    );
  }
  Future<void> _getData(BuildContext context) =>
      context.read<ShopProvider>().getFavouriteStore();
}
