import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/about/about_controller.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

class AboutBottom extends StatelessWidget {
  const AboutBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: .generate(controller.res["banners"].length, (index) {
        final items = controller.res["banners"][index];

        return Expanded(child: MyImageAssets(items, fit: .cover, scale: 1));
      }),
    );
  }
}
