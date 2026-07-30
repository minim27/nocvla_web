import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../shared/widgets/my_button.dart';

class TCartSummary extends StatelessWidget {
  const TCartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Expanded(
      child: Container(
        padding: .all(24),
        decoration: BoxDecoration(
          border: .all(color: MyColors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          spacing: 16,
          children: [
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
                MyText(text: "CALCULATED BY ADMIN"),
              ],
            ),
            Obx(() {
              controller.refreshSubtotal.value;

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
            MyDivider(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                MyText(text: "TOTAL", fontWeight: .w600, fontSize: 18),
                Obx(() {
                  controller.refreshSubtotal.value;

                  return MyText(
                    text: parsingCurrency(controller.total),
                    fontWeight: .w600,
                    fontSize: 18,
                  );
                }),
              ],
            ),
            MyButton("CHECKOUT", onTap: () => controller.checkout()),
          ],
        ),
      ),
    );
  }
}
