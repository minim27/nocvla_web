import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_divider.dart';
import '../../../../shared/widgets/my_panel.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../cart_controller.dart';

class TCartSummary extends StatelessWidget {
  const TCartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return MyPanel(
      child: Obx(() {
        controller.refreshSubtotal.value;

        return Column(
          crossAxisAlignment: .stretch,
          spacing: 16,
          children: [
            row("Subtotal", parsingCurrency(controller.subTotal)),
            if (controller.discountAmount > 0)
              row(
                "Diskon (${controller.appliedCode.value})",
                "- ${parsingCurrency(controller.discountAmount)}",
              ),
            row("Ongkir", "Dihitung admin via WhatsApp"),
            MyDivider(),
            row("Total", parsingCurrency(controller.total)),
            MyText(text: "PRATINJAU PESAN", color: MyColors.white2),
            Container(
              padding: .all(12),
              color: MyColors.black,
              child: MyText(text: controller.orderPreview, fontSize: 13),
            ),
            MyButton(
              "KIRIM ORDER KE WHATSAPP",
              color: MyColors.red,
              textColor: MyColors.nativeWhite,
              enable: !controller.isSending.value,
              onTap: controller.sendOrder,
            ),
          ],
        );
      }),
    );
  }

  Widget row(String label, String value) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: MyText(text: label, color: MyColors.white2),
        ),
        Flexible(
          child: MyText(text: value, textAlign: .end, fontWeight: .w600),
        ),
      ],
    );
  }
}
