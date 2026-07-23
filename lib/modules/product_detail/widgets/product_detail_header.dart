import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../../../shared/utils/my_parsing_currency.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final items = controller.res;

    return Padding(
      padding: .all(40),
      child: Row(crossAxisAlignment: .start,
        spacing: 42,
        children: [
          Row(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  spacing: 12,
                  children: .generate(items["images"].length, (index) {
                    final images = items["images"][index];

                    return GestureDetector(
                      onTap: () => controller.selectImage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.black2,
                          border: .all(
                            color: MyColors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        width: 90,
                        child: MyImage(images),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: 550,
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Container(
                    color: MyColors.black2,
                    child: Obx(
                      () => MyImage(
                        items["images"][controller.selectedImage.value],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              spacing: 32,
              crossAxisAlignment: .start,
              children: [
                identity(controller, items),
                size(controller),
                qty(controller),
                Column(
                  spacing: 16,
                  crossAxisAlignment: .start,
                  children: .generate(items["features"].length, (index) {
                    final features = items["features"][index];

                    return Row(
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: MyImageAssets(features["icon"], fit: .cover),
                        ),
                        MyText(
                          text: features["label"],
                          color: MyColors.white.withValues(alpha: 0.6),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget identity(
    ProductDetailController controller,
    Map<String, dynamic> items,
  ) {
    return Obx(
      () => Column(
        spacing: 24,
        crossAxisAlignment: .start,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              MyText(
                text: "${items["name"]} - ${items["color"]}",
                fontSize: 20,
                fontWeight: .w600,
              ),
              MyText(
                text: "- ${items["color"]}",
                fontSize: 24,
                fontWeight: .w600,
              ),
            ],
          ),
          if (controller.selectedStock.value != null)
            MyText(
              text: parsingCurrency(controller.selectedStock.value!["price"]),
              fontSize: 18,
              fontWeight: .w600,
            ),
          MyText(
            text: items["description"],
            fontSize: 16,
            color: MyColors.white2,
          ),
        ],
      ),
    );
  }

  Column qty(ProductDetailController controller) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        MyText(
          text: "QTY",
          color: MyColors.white.withValues(alpha: 0.6),
          fontWeight: .w500,
        ),
        Row(
          children: [
            GestureDetector(
              behavior: .opaque,
              onTap: () => controller.decrease(),
              child: Container(
                alignment: .center,
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                ),
                child: Icon(
                  Icons.remove,
                  color: MyColors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
            Container(
              alignment: .center,
              width: 50,
              height: 45,
              decoration: BoxDecoration(
                border: .all(color: MyColors.white.withValues(alpha: 0.1)),
              ),
              child: Obx(
                () => MyTextFormFieldNoBorder(
                  controller: TextEditingController(
                    text: controller.qty.value.toString(),
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: .opaque,
              onTap: () => controller.increase(),
              child: Container(
                alignment: .center,
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                ),
                child: Icon(
                  Icons.add,
                  color: MyColors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column size(ProductDetailController controller) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        MyText(
          text: "SIZE",
          color: MyColors.white.withValues(alpha: 0.6),
          fontWeight: .w500,
        ),
        Row(
          spacing: 6,
          children: .generate(controller.res["stock"].length, (index) {
            final items = controller.res["stock"][index];

            return GestureDetector(
              onTap: () => controller.selectStock(items),
              child: Obx(
                () => Container(
                  alignment: .center,
                  width: 40,
                  height: 45,
                  decoration: BoxDecoration(
                    color: controller.selectedStock.value == items
                        ? MyColors.white
                        : MyColors.white.withValues(alpha: 0),
                    border: .all(
                      color: controller.selectedStock.value == items
                          ? MyColors.white
                          : MyColors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: MyText(
                    text: items["size"],
                    color: controller.selectedStock.value == items
                        ? MyColors.black
                        : MyColors.white.withValues(alpha: 0.6),
                    fontWeight: controller.selectedStock.value == items
                        ? .w500
                        : .w400,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
