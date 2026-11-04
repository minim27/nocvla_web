import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../product_detail_controller.dart';

class ProductDetailOrderDialog extends GetView<ProductDetailController> {
  const ProductDetailOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final subTotal =
        controller.selectedStock.value!["price"] * controller.qty.value;

    return Dialog(
      insetPadding: .all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: .all(24),
          child: Obx(
            () => Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              spacing: 16,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: "ORDER VIA WHATSAPP",
                        fontFamily: MyFonts.grenzeGotisch,
                        fontSize: 28,
                        fontWeight: .w600,
                      ),
                    ),
                    GestureDetector(
                      behavior: .opaque,
                      onTap: () => Get.back(),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(Icons.close, color: MyColors.white2),
                      ),
                    ),
                  ],
                ),
                row("Subtotal", parsingCurrency(subTotal)),
                if (controller.discountAmount > 0)
                  row(
                    "Diskon",
                    "- ${parsingCurrency(controller.discountAmount)}",
                  ),
                row("Ongkir", "Dihitung admin via WhatsApp"),
                MyTextFormField(
                  controller: controller.txtCode,
                  label: "KODE ATLET",
                  hintText: "Masukkan kode",
                ),
                MyButtonBorder(
                  "PAKAI KODE",
                  enable: !controller.isValidatingCode.value,
                  onTap: controller.applyCode,
                ),
                MyText(text: "PRATINJAU PESAN", color: MyColors.white2),
                Container(
                  padding: .all(12),
                  color: MyColors.black,
                  child: MyText(text: controller.orderPreview, fontSize: 13),
                ),
                MyButton(
                  "KIRIM KE WHATSAPP",
                  color: MyColors.red,
                  textColor: MyColors.nativeWhite,
                  enable: !controller.isSending.value,
                  onTap: controller.sendOrder,
                ),
              ],
            ),
          ),
        ),
      ),
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
          child: MyText(text: value, textAlign: .end),
        ),
      ],
    );
  }
}
