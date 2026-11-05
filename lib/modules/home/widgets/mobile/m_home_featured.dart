import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class MHomeFeatured extends StatelessWidget {
  const MHomeFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(24, 64, 24, 0),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          Row(
            crossAxisAlignment: .end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4,
                  children: [eyebrow("PILIHAN TEMPLE"), title("Featured")],
                ),
              ),
              GestureDetector(
                behavior: .opaque,
                onTap: controller.openCollection,
                child: Container(
                  height: 44,
                  alignment: .bottomCenter,
                  child: Container(
                    padding: .only(bottom: 6),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: MyColors.line2)),
                    ),
                    child: MyText(
                      text: "SEMUA PRODUK",
                      fontFamily: MyFonts.archivoNarrow,
                      fontSize: 12,
                      fontWeight: .w700,
                      letterSpacing: 12 * 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            if (controller.isLoadingFeatured.value) {
              return MyGrid(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < 2; i++)
                    AspectRatio(
                      aspectRatio: 4 / 5,
                      child: MySkeleton(height: null),
                    ),
                ],
              );
            }

            return MyGrid(
              crossAxisCount: 2,
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

  Widget eyebrow(String text, {Color color = MyColors.white2}) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w600,
      letterSpacing: 12 * 0.3,
      color: color,
    );
  }

  Widget title(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.grenzeGotisch,
      fontSize: 32,
      fontWeight: .w600,
      height: 1.1,
    );
  }
}
