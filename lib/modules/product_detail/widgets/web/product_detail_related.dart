import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../product_detail_controller.dart';

class ProductDetailRelated extends StatelessWidget {
  const ProductDetailRelated({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Obx(() {
      if (controller.resRelated.isEmpty) return SizedBox();

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
          child: Padding(
            padding: .fromLTRB(48, 112, 48, 112),
            child: SizedBox(
              width: .infinity,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 28,
                children: [
                  MyText(
                    text: "Lengkapi ritualmu",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 38,
                    fontWeight: .w700,
                    height: 1.0,
                  ),
                  MyGrid(
                    crossAxisCount: 3,
                    spacing: 20,
                    children: [
                      for (final items in controller.resRelated)
                        GestureDetector(
                          onTap: () => controller.openRelated(items.id),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 5,
                                child: Container(
                                  color: MyColors.black4,
                                  child: MyImage(items.imageUrl),
                                ),
                              ),
                              SizedBox(height: 14),
                              MyText(
                                text: "${items.name}",
                                fontSize: 14,
                                fontWeight: .w700,
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                text: parsingCurrency(items.price),
                                fontSize: 14,
                                color: MyColors.white2,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
