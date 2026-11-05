import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_grid.dart';
import '../../../../../shared/widgets/my_product_card.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_detail_controller.dart';

class MAthleteDetailBody extends StatelessWidget {
  const MAthleteDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Padding(
      padding: .fromLTRB(24, 64, 24, 64),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "PRODUK",
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 12,
            fontWeight: .w600,
            letterSpacing: 12 * 0.3,
            color: MyColors.white2,
          ),
          SizedBox(height: 4),
          MyText(
            text: "Yang dipakai",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 32,
            fontWeight: .w600,
            height: 1.1,
          ),
          SizedBox(height: 24),
          Obx(() {
            if (controller.isLoadingProducts.value) {
              return MyGrid(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < 2; i++)
                    AspectRatio(
                      aspectRatio: 1,
                      child: MySkeleton(height: null),
                    ),
                ],
              );
            }

            return MyGrid(
              crossAxisCount: 2,
              children: [
                for (final items in controller.resProducts)
                  MyProductCard(
                    item: items,
                    colorFontSize: 22,
                    onTap: () => controller.openDetail(items),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
