import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/product_detail/product_detail_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class MProductDetailPayment extends StatelessWidget {
  const MProductDetailPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final items = controller.res["links"];

    return Padding(
      padding: .fromLTRB(24, 0, 24, 40),
      child: Column(
        spacing: 12,
        children: [
          Container(
            padding: .symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(color: MyColors.white),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              spacing: 16,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: MyImageAssets(MyIcons.icBag, fit: .cover),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 12,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        spacing: 12,
                        children: [
                          Flexible(
                            child: MyText(
                              text: "ORDER DISINI LEBIH MURAH",
                              fontSize: 14,
                              fontWeight: .w700,
                              color: MyColors.black,
                            ),
                          ),
                          GestureDetector(
                            behavior: .opaque,
                            onTap: () => controller.addToCart(),
                            child: Obx(() {
                              int? total;

                              if (controller.selectedStock.value != null) {
                                total =
                                    controller.selectedStock.value!["price"] *
                                    controller.qty.value;
                              }

                              return Row(
                                spacing: 12,
                                children: [
                                  MyText(
                                    text:
                                        (controller.selectedStock.value == null)
                                        ? "-"
                                        : parsingCurrency(total),
                                    fontSize: 18,
                                    fontWeight: .w700,
                                    color: MyColors.black,
                                  ),
                                  Icon(
                                    size: 18,
                                    Icons.arrow_forward_ios_rounded,
                                    color: MyColors.black,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (items["shopee"] != null && items["shopee"] != "")
            GestureDetector(
              behavior: .opaque,
              onTap: () => execUri(items["shopee"]),
              child: Container(
                padding: .symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  border: .all(
                    color: MyColors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: MyImageAssets(MyIcons.icShopee, fit: .cover),
                        ),
                        MyText(text: "BELI DI SHOPEE"),
                      ],
                    ),
                    Icon(
                      size: 12,
                      Icons.arrow_forward_ios_rounded,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ),
          if (items["tiktok"] != null && items["tiktok"] != "")
            GestureDetector(
              behavior: .opaque,
              onTap: () => execUri(items["tiktok"]),
              child: Container(
                padding: .symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  border: .all(
                    color: MyColors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: MyImageAssets(MyIcons.icTikTok2, fit: .cover),
                        ),
                        MyText(text: "BELI DI TIKTOK"),
                      ],
                    ),
                    Icon(
                      size: 12,
                      Icons.arrow_forward_ios_rounded,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ),
          if (items["tokopedia"] != null && items["tokopedia"] != "")
            GestureDetector(
              behavior: .opaque,
              onTap: () => execUri(items["tokopedia"]),
              child: Container(
                padding: .symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  border: .all(
                    color: MyColors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: MyImageAssets(MyIcons.icTokped, fit: .cover),
                        ),
                        MyText(text: "BELI DI TOKOPEDIA"),
                      ],
                    ),
                    Icon(
                      size: 12,
                      Icons.arrow_forward_ios_rounded,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            spacing: 8,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: MyImageAssets(MyIcons.icComfort, fit: .cover),
              ),
              MyText(
                text: "100% Secure Payment",
                color: MyColors.white.withValues(alpha: 0.6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
