import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../product_detail_controller.dart';

class ProductDetailRelated extends StatelessWidget {
  const ProductDetailRelated({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Obx(() {
      if (controller.resRelated.isEmpty) return SizedBox();

      return Padding(
        padding: .fromLTRB(40, 0, 40, 40),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 24,
          children: [
            MyText(
              text: "PRODUK TERKAIT",
              fontFamily: MyFonts.grenzeGotisch,
              fontSize: 36,
              fontWeight: .w600,
            ),
            MyGrid(
              crossAxisCount: 4,
              children: [
                for (final items in controller.resRelated)
                  MyProductCard(
                    item: items,
                    colorFontSize: 24,
                    onTap: () => controller.openRelated(items.id),
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
