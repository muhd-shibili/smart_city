import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_city/core/model/banner/banner_model.dart';
import 'package:smart_city/ui/widgets/image/custom_network_image.dart';

import '../../../utils/constants/image_assets.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.bannerModel});
final BannerModel bannerModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(

      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: CustomNetworkImage(imagePath: bannerModel.image, fit: BoxFit.cover,),
    );
  }
}
