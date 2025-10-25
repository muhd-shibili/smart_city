import 'package:flutter/material.dart';

import '../../../utils/helper/image_helper.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      ImageHelper.showImage(
        imagePath,
      ),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => SizedBox(
          height: height,
          width: width,
          child: const Center(
            child: Icon(
              Icons.error_outline,
              size: 20,
              color: Colors.black,
            ),
          )),
    );
  }
}
