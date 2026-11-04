import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_grid.dart';
import '../../../../../shared/widgets/my_product_card.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_detail_controller.dart';

class AthleteDetailBody extends StatelessWidget {
  const AthleteDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Padding(
      padding: .all(40),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          MyText(
            text: "PRODUK YANG DIPAKAI",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 40,
            fontWeight: .w600,
          ),
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
                    colorFontSize: 24,
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
