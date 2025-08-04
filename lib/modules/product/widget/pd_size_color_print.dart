import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/utils/my_fonts.dart';
import '../../../shared/widgets/my_text.dart';
import '../product_detail_controller.dart';

class PDSizeColorPrint extends GetView<ProductDetailController> {
  const PDSizeColorPrint({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "Size",
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...List.generate(
              controller.res[0].variation.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => controller.selectSize(index: index),
                child: Obx(
                  () => Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primary60),
                      color: controller.selectedSize.value == index
                          ? MyColors.secondary
                          : MyColors.primary,
                    ),
                    child: Center(
                      child: MyText(
                        text: controller.res[0].variation[index]["name"],
                        color: controller.selectedSize.value == index
                            ? MyColors.primary
                            : MyColors.secondary,
                        fontFamily: MyFonts.libreBaskerville,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        MyText(
          text: "Color",
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...List.generate(
              controller
                  .res[0]
                  .variation[controller.selectedSize.value]["color"]
                  .length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => controller.selectColor(index: index),
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.selectedColor.value == index
                            ? MyColors.secondary
                            : MyColors.primary,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: hexToColor(
                          hex:
                              controller.res[0].variation[controller
                                  .selectedSize
                                  .value]["color"][index]["hex"],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            MyText(
              text: "Variation",
              fontFamily: MyFonts.libreBaskerville,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...List.generate(
                  controller
                      .res[0]
                      .variation[controller
                          .selectedSize
                          .value]["color"][controller
                          .selectedColor
                          .value]["print"]
                      .length,
                  (index) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => controller.selectPrint(index: index),
                    child: Obx(
                      () => Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.selectedPrint.value == index
                                ? MyColors.secondary
                                : MyColors.primary,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: hexToColor(
                                      hex:
                                          controller.res[0].variation[controller
                                              .selectedSize
                                              .value]["color"][controller
                                              .selectedColor
                                              .value]["print"][index]["primary_hex"],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: hexToColor(
                                      hex:
                                          controller.res[0].variation[controller
                                              .selectedSize
                                              .value]["color"][controller
                                              .selectedColor
                                              .value]["print"][index]["secondary_hex"],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
