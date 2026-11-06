import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import '../../cart_controller.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Container(
      padding: .all(28),
      decoration: BoxDecoration(
        color: MyColors.black4,
        border: .all(color: MyColors.line2),
      ),
      child: Obx(() {
        controller.refreshSubtotal.value;

        return Column(
          crossAxisAlignment: .stretch,
          children: [
            MyText(
              text: "Ringkasan",
              fontFamily: MyFonts.grenzeGotisch,
              fontSize: 27,
              fontWeight: .w700,
              height: 1.2,
            ),
            SizedBox(height: 18),
            label("KODE ATLET (OPSIONAL)"),
            SizedBox(height: 10),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: MyTextFormField(
                    controller: controller.txtCode,
                    hintText: "CONTOH: ARAHIE",
                    height: 50,
                    fontSize: 13.5,
                    fillColor: MyColors.black3,
                    borderColor: MyColors.swatchBorder,
                    hintColor: MyColors.placeholder,
                    padding: .symmetric(horizontal: 15, vertical: 16),
                    onFieldSubmitted: (_) => controller.applyCode(),
                  ),
                ),
                MyButton(
                  "PAKAI",
                  width: 74,
                  height: 50,
                  fontSize: 12.5,
                  fontWeight: .w700,
                  enable: !controller.isValidatingCode.value,
                  onTap: controller.applyCode,
                ),
              ],
            ),
            SizedBox(height: 10),
            if (controller.appliedCode.value == null)
              MyText(
                text: "Punya kode dari atlet NOCVLA? Masukkan di sini.",
                fontSize: 12.5,
                color: MyColors.white2,
              )
            else
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyText(
                      text: "Kode ${controller.appliedCode.value} terpasang",
                      fontSize: 12.5,
                      color: MyColors.green,
                    ),
                  ),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: controller.removeCode,
                    child: MyText(
                      text: "Hapus",
                      fontSize: 12.5,
                      color: MyColors.white2,
                      decoration: .underline,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            Divider(height: 1, color: MyColors.line2),
            SizedBox(height: 17),
            row(
              "Subtotal (${controller.totalQty} pcs)",
              parsingCurrency(controller.subTotal),
            ),
            if (controller.discountAmount > 0) ...[
              SizedBox(height: 11),
              row(
                "Diskon (${controller.appliedCode.value})",
                "- ${parsingCurrency(controller.discountAmount)}",
              ),
            ],
            SizedBox(height: 11),
            row("Ongkir", "Dihitung admin via WhatsApp"),
            SizedBox(height: 16),
            Divider(height: 1, color: MyColors.line2),
            SizedBox(height: 22),
            Row(
              crossAxisAlignment: .center,
              spacing: 12,
              children: [
                Expanded(child: label("TOTAL SEMENTARA")),
                MyText(
                  text: parsingCurrency(controller.total),
                  fontSize: 21,
                  fontWeight: .w700,
                ),
              ],
            ),
            SizedBox(height: 21),
            Container(
              decoration: BoxDecoration(border: .all(color: MyColors.line2)),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  GestureDetector(
                    behavior: .opaque,
                    onTap: controller.toggleMessage,
                    child: Padding(
                      padding: .symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        spacing: 9,
                        children: [
                          Icon(
                            controller.isShowMessage.value
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right,
                            color: MyColors.white3,
                            size: 16,
                          ),
                          MyText(
                            text: "Lihat pesan yang akan dikirim",
                            fontSize: 13,
                            color: MyColors.white3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isShowMessage.value)
                    Padding(
                      padding: .fromLTRB(16, 0, 16, 16),
                      child: MyText(
                        text: controller.buildMessage(),
                        fontSize: 13,
                        height: 1.67,
                        color: MyColors.white3,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            MyButton(
              "KIRIM ORDER KE WHATSAPP",
              height: 56,
              color: MyColors.red,
              textColor: MyColors.nativeWhite,
              fontSize: 13.5,
              fontWeight: .w700,
              prefixIcon: Icons.chat_bubble_outline,
              enable: !controller.isPlacingOrder.value,
              onTap: controller.placeOrder,
            ),
            SizedBox(height: 22),
            MyText(
              text:
                  "Semua item dikirim dalam satu pesan. Admin membalas dengan total ongkir dan info pembayaran.",
              fontSize: 12.5,
              height: 1.6,
              color: MyColors.white4,
            ),
          ],
        );
      }),
    );
  }

  Widget label(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w700,
      letterSpacing: 12 * 0.18,
    );
  }

  Widget row(String label, String value) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: MyText(text: label, fontSize: 13.5, color: MyColors.white2),
        ),
        MyText(text: value, fontSize: 13.5, textAlign: .end),
      ],
    );
  }
}
