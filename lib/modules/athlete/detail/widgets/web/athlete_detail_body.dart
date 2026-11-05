import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_grid.dart';
import '../../../../../shared/widgets/my_max_width.dart';
import '../../../../../shared/widgets/my_product_card.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_detail_controller.dart';

class AthleteDetailBody extends StatelessWidget {
  const AthleteDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return MyMaxWidth(
      child: Padding(
        padding: .only(top: 112, bottom: 112),
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
              fontSize: 48,
              fontWeight: .w600,
              height: 1.1,
            ),
            SizedBox(height: 24),
            Obx(() {
              if (controller.isLoadingProducts.value) {
                return MyGrid(
                  crossAxisCount: 4,
                  children: [
                    for (var i = 0; i < 4; i++)
                      AspectRatio(
                        aspectRatio: 1,
                        child: MySkeleton(height: null),
                      ),
                  ],
                );
              }

              return MyGrid(
                crossAxisCount: 4,
                children: [
                  for (final items in controller.resProducts)
                    MyProductCard(
                      item: items,
                      colorFontSize: 29.5,
                      onTap: () => controller.openDetail(items),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
