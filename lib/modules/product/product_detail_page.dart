import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/services/my_config.dart';
import 'package:nocvla/modules/product/product_detail_controller.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_vectors.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';
import 'package:nocvla/shared/widgets/my_text_form_field.dart';

import '../../shared/utils/my_fonts.dart';
import '../../shared/utils/my_icons.dart';
import '../../shared/utils/my_images.dart';
import '../../shared/utils/my_utility.dart';
import '../../shared/widgets/my_image.dart';
import '../../shared/widgets/my_loading.dart';
import 'widget/pd_desc.dart';
import 'widget/pd_images.dart';
import 'widget/pd_size_color_print.dart';
import 'widget/pd_title_price.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return MyLoading();

      return Stack(
        children: [
          MyScaffold(
            appBar: AppBar(
              title: SizedBox(
                width: 70,
                child: MyImageAssets(assets: MyImages.imgNocvla),
              ),
              centerTitle: true,
              actions: [
                SizedBox(
                  height: 18,
                  width: 18,
                  child: MyImageAssets(assets: MyIcons.icAccount),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => openCart(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: MyImageAssets(assets: MyIcons.icCart),
                      ),
                      Visibility(
                        visible: controller.resCart.isNotEmpty,
                        child: Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 16),
              ],
            ),
            body: ListView(
              padding: EdgeInsets.only(bottom: 24),
              children: [
                PDImages(),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PDTitlePrice(),
                      SizedBox(height: 24),
                      PDDesc(),
                      SizedBox(height: 24),
                      PDSizeColorPrint(),
                      SizedBox(height: 24),
                      (MyConfig.isECommerce)
                          ? Row(
                              spacing: 8,
                              children: [
                                MyText(text: "Quantity"),
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
                                              onTap: () =>
                                                  controller.decreaseQty(),
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
                                                      int.tryParse(value) ==
                                                          null ||
                                                      int.parse(value) <= 0) {
                                                    controller.txtQty.text =
                                                        '1';
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
                                              onTap: () =>
                                                  controller.increaseQty(),
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
                                          onTap: () => controller.addToCart(
                                            res: controller.res[0],
                                          ),
                                        ),
                                        // MyButton(
                                        //   width: 120,
                                        //   color: MyColors.primary90,
                                        //   textColor: MyColors.secondary,
                                        //   text: "Order Now",
                                        //   onTap: () => controller.orderNow(),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                MyText(
                                  text: "ORDER NOW",
                                  fontFamily: MyFonts.libreBaskerville,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                                SizedBox(height: 18),
                                MyIconButton(
                                  height: 100,
                                  borderRadius: 0,
                                  color: MyColors.shopee,
                                  icon: MyVectors.vecShopee,
                                  text: "Shopee",
                                  fontSize: 36,
                                  textColor: MyColors.secondary,
                                  onTap: () =>
                                      execUri(uri: controller.res[0].urlShopee),
                                ),
                                SizedBox(height: 18),
                                MyIconButton(
                                  height: 100,
                                  borderRadius: 0,
                                  color: MyColors.tiktok,
                                  icon: MyVectors.vecTikTokShop,
                                  text: "TikTok Shop",
                                  fontSize: 36,
                                  textColor: MyColors.secondary,
                                  onTap: () => execUri(
                                    uri: controller.res[0].urlTiktokshop,
                                  ),
                                ),
                                SizedBox(height: 18),
                                MyIconButton(
                                  height: 100,
                                  borderRadius: 0,
                                  color: MyColors.tokped,
                                  icon: MyVectors.vecTokopedia,
                                  text: "Tokopedia",
                                  fontSize: 36,
                                  textColor: MyColors.secondary,
                                  onTap: () =>
                                      execUri(uri: controller.res[0].urlTokped),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoadingAction.value,
              child: const MyLoading(isStack: true),
            ),
          ),
        ],
      );
    });
  }
}
