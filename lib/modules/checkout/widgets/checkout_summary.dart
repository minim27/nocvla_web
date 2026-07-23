import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
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
                Obx(() {
                  controller.refreshSubtotal.value;

                  return MyText(
                    text: parsingCurrency(controller.subTotal),
                    fontWeight: .w500,
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "SHIPPING"),
                MyText(text: "PAID BY BUYER"),
              ],
            ),
            MyDivider(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "TOTAL", fontWeight: .w600, fontSize: 18),
                Obx(() {
                  controller.refreshSubtotal.value;

                  return MyText(
                    text: parsingCurrency(controller.subTotal),
                    fontWeight: .w600,
                    fontSize: 18,
                  );
                }),
              ],
            ),
            SizedBox(height: 16),
            MyButton("PLACE ORDER", onTap: () => null),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> products(CheckoutController controller) {
    return .generate(controller.res.length, (index) {
      final items = controller.res[index];

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
                child: MyImageAssets(items["image"], fit: .cover),
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(
                    text: "${items["label"]} - ${items["color"]}",
                    fontWeight: .w600,
                  ),
                  MyText(
                    text: "SIZE ${items["size"]}",
                    color: MyColors.white.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ],
          ),
          MyText(text: "${parsingCurrency(items["price"])} x${items["qty"]}"),
        ],
      );
    });
  }
}
