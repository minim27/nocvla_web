import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class THomeFeatured extends StatelessWidget {
  const THomeFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 32,
        children: [
          MyText(
            text: "FEATURED",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 40,
            fontWeight: .w600,
          ),
          Obx(() {
            if (controller.isLoadingFeatured.value) {
              return MyGrid(
                crossAxisCount: 3,
                children: [
                  for (var i = 0; i < 3; i++)
                    AspectRatio(
                      aspectRatio: 1,
                      child: MySkeleton(height: null),
                    ),
                ],
              );
            }

            return MyGrid(
              crossAxisCount: 3,
              children: [
                for (final items in controller.resFeatured)
                  MyFeaturedCard(
                    item: items,
                    onTap: () => controller.openDetail(items.id),
                    onColorTap: controller.openDetail,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
