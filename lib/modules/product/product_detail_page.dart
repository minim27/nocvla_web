import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/product/product_detail_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text_form_field.dart';

import '../../shared/widgets/my_loading.dart';
import 'widget/pd_desc.dart';
import 'widget/pd_images.dart';
import 'widget/pd_size_color_print.dart';
import 'widget/pd_title_price.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return MyScaffold(
      body: (controller.isLoading.value)
          ? MyLoading()
          : ListView(
              padding: EdgeInsets.only(bottom: 24),
              children: [
                PDImages(controller: controller),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PDTitlePrice(controller: controller),
                      SizedBox(height: 24),
                      PDDesc(controller: controller),
                      SizedBox(height: 24),
                      PDSizeColorPrint(controller: controller),
                      SizedBox(height: 24),
                      Wrap(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FittedBox(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.primary90,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.decreaseQty(),
                                    child: Icon(
                                      Icons.remove,
                                      color: MyColors.secondary,
                                    ),
                                  ),
                                  Container(
                                    color: MyColors.primary90,
                                    width: 3,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: MyTextFormFieldNoBorder(
                                      controller: controller.txtQty,
                                      textColor: MyColors.secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      onChanged: (value) {
                                        if (value.isEmpty ||
                                            int.tryParse(value) == null ||
                                            int.parse(value) <= 0) {
                                          controller.txtQty.text = '1';
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: MyColors.primary90,
                                    width: 3,
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.increaseQty(),
                                    child: Icon(
                                      Icons.add,
                                      color: MyColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 12,
                            children: [
                              MyButton(
                                width: 120,
                                color: MyColors.red,
                                textColor: MyColors.secondary,
                                text: "Add to Cart",
                                onTap: () => controller.addToCart(),
                              ),
                              MyButton(
                                width: 120,
                                color: MyColors.primary90,
                                textColor: MyColors.secondary,
                                text: "Order Now",
                                onTap: () => controller.orderNow(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
