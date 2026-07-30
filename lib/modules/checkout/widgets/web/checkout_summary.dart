import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/data/models/cart/cart_item_model.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_image.dart';
import '../checkout_controller.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();

    return Expanded(
      child: Container(
        padding: .all(24),
        decoration: BoxDecoration(
          border: .all(color: MyColors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: .start,
          children: [
            MyText(text: "ORDER SUMMARY", fontWeight: .w600, fontSize: 16),
            ...products(controller),
            MyDivider(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "SUBTOTAL", fontWeight: .w500),
                Obx(
                  () => MyText(
                    text: parsingCurrency(controller.subTotal),
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
            Obx(() {
              if (controller.appliedCode.value == null) return SizedBox();

              return Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  MyText(text: "DISCOUNT (${controller.appliedCode.value})"),
                  MyText(
                    text: "- ${parsingCurrency(controller.discountAmount)}",
                  ),
                ],
              );
            }),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "SHIPPING"),
                MyText(text: "CALCULATED BY ADMIN"),
              ],
            ),
            MyDivider(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "TOTAL", fontWeight: .w600, fontSize: 18),
                Obx(
                  () => MyText(
                    text: parsingCurrency(controller.total),
                    fontWeight: .w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              spacing: 12,
              children: [
                MyButton(
                  "ORDER VIA WHATSAPP",
                  textColor: MyColors.white,
                  prefix: MyIcons.icWhatsapp,
                  color: MyColors.whatsApp,
                  scale: 6,
                  onTap: () => controller.placeOrder(),
                ),
                MyButton(
                  "ORDER VIA INSTAGRAM",
                  textColor: MyColors.white,
                  prefix: MyIcons.icInstagram,
                  color: MyColors.instagram,
                  scale: 6,
                  onTap: () => controller.placeOrderViaInstagram(),
                ),
                MyButton(
                  "ORDER VIA TIKTOK",
                  textColor: MyColors.white,
                  prefix: MyIcons.icTikTok2,
                  color: MyColors.nativeBlack,
                  scale: 10,
                  onTap: () => controller.placeOrderViaTiktok(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> products(CheckoutController controller) {
    return .generate(controller.resItems.length, (index) {
      final CartItemModel items = controller.resItems[index];

      return Row(
        spacing: 12,
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            spacing: 12,
            children: [
              Container(
                color: MyColors.black2,
                width: 80,
                height: 80,
                child: MyImage(items.imageUrl, fit: .cover),
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(text: items.name, fontWeight: .w600),
                  MyText(
                    text: "${items.size} / ${items.color}",
                    fontStyle: .italic,
                    fontSize: 12,
                    color: MyColors.white.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ],
          ),
          MyText(text: "${parsingCurrency(items.price)} x${items.qty.value}"),
        ],
      );
    });
  }
}
