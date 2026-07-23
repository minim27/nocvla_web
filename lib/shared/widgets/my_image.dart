import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'my_loading.dart';

class MyImage extends StatelessWidget {
  const MyImage(
    this.image, {
    super.key,
    this.scale = 1,

    this.fit = .cover,
    this.errorWidget,
    this.alignment = .center,
    this.onTap,
  });

  final double scale;
  final dynamic image;
  final Alignment alignment;
  final BoxFit fit;
  final Widget? errorWidget;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: (image == null)
          ? MyImage(
              "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
            )
          : CachedNetworkImage(
              imageUrl: "${dotenv.env["API_URL"]}/${dotenv.env["API_STORAGE"]}/$image",
              fit: fit,
              scale: scale,
              alignment: alignment,
              placeholder: (context, url) =>
                  MyLoading(backgroundColor: Colors.transparent),
              errorWidget: (context, url, error) =>
                  errorWidget ??
                  MyImage(
                    "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                  ),
            ),
    );
  }
}

class MyImageAssets extends StatelessWidget {
  const MyImageAssets(
    this.image, {
    super.key,
    this.scale = 4,
    this.fit = .none,
    this.color,
    this.alignment = .center,
  });

  final String image;
  final double scale;
  final BoxFit fit;
  final Color? color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) => Image.asset(
    image,
    scale: scale,
    fit: fit,
    color: color,
    alignment: alignment,
  );
}
