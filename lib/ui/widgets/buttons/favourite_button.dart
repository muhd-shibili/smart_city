import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_city/core/model/shop/shop_model.dart';
import 'package:smart_city/core/provider/shop_provider.dart';

class FavouriteButton extends StatelessWidget {
  final ShopModel shop;
  final bool isBusy;

  const FavouriteButton({
    super.key,
    required this.shop,
    required this.isBusy,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await context.read<ShopProvider>().addRemoveFavouriteStores(shop.id);
        // .(productId: product.id);
      },
      icon: Icon(
        shop.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: shop.isFavorite ? Colors.red : Colors.white,
      ),
    );
  }
}
