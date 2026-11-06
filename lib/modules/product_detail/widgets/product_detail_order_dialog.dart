import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/utils/my_fonts.dart';
import '../../../shared/utils/my_parsing_currency.dart';
import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_image.dart';
import '../../../shared/widgets/my_text.dart';
import '../../../shared/widgets/my_text_form_field.dart';
import '../product_detail_controller.dart';

class ProductDetailOrderDialog extends StatelessWidget {
  const ProductDetailOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final width = MediaQuery.sizeOf(context).width;

    return Align(
      alignment: .centerRight,
      child: Material(
        color: MyColors.black4,
        child: Container(
          width: width < 458 ? width : 458,
          height: .infinity,
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: MyColors.line2)),
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Container(
                padding: .fromLTRB(24, 24, 16, 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: MyColors.line2)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: "Ringkasan order",
                        fontFamily: MyFonts.grenzeGotisch,
                        fontSize: 27,
                        fontWeight: .w700,
                        height: 1.2,
                      ),
                    ),
                    GestureDetector(
                      behavior: .opaque,
                      onTap: Get.back,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.close,
                          color: MyColors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: .fromLTRB(24, 24, 24, 32),
                  child: Obx(() {
                    final item = controller.selectedItem();

                    return Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        Row(
                          crossAxisAlignment: .start,
                          spacing: 17,
                          children: [
                            SizedBox(
                              width: 88,
                              height: 110,
                              child: MyImage(item.imageUrl),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 6,
                                children: [
                                  MyText(
                                    text: "${item.name}",
                                    fontSize: 14.5,
                                    fontWeight: .w600,
                                  ),
                                  MyText(
                                    text:
                                        "${"${item.color}".capitalize} · Ukuran ${item.size} · ${item.qty.value} pcs",
                                    fontSize: 13.5,
                                    color: MyColors.white2,
                                  ),
                                  MyText(
                                    text: parsingCurrency(
                                      (item.price as int) * item.qty.value,
                                    ),
                                    fontSize: 13.5,
                                    fontWeight: .w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 27),
                        label("KODE ATLET (OPSIONAL)", MyColors.white),
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
                                padding: .symmetric(
                                  horizontal: 15,
                                  vertical: 16,
                                ),
                                onFieldSubmitted: (_) => controller.applyCode(),
                              ),
                            ),
                            MyButton(
                              "PAKAI",
                              width: 77,
                              height: 50,
                              fontSize: 12.5,
                              fontWeight: .w700,
                              enable: !controller.isValidatingCode.value,
                              onTap: controller.applyCode,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        MyText(
                          text: controller.appliedCode.value == null
                              ? "Punya kode dari atlet NOCVLA? Masukkan di sini."
                              : "Kode ${controller.appliedCode.value} terpasang",
                          fontSize: 12.5,
                          color: controller.appliedCode.value == null
                              ? MyColors.white2
                              : MyColors.green,
                        ),
                        SizedBox(height: 24),
                        Divider(height: 1, color: MyColors.line2),
                        SizedBox(height: 17),
                        row(
                          "Subtotal",
                          parsingCurrency((item.price as int) * item.qty.value),
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
                        SizedBox(height: 26),
                        label("PESAN YANG AKAN DIKIRIM", MyColors.white2),
                        SizedBox(height: 11),
                        Container(
                          padding: .fromLTRB(17, 15, 17, 17),
                          decoration: BoxDecoration(
                            color: MyColors.black3,
                            border: .all(color: MyColors.line2),
                          ),
                          child: MyText(
                            text: controller.buildMessage(),
                            fontSize: 13.5,
                            height: 1.67,
                            color: MyColors.white3,
                          ),
                        ),
                        SizedBox(height: 24),
                        MyButton(
                          "KIRIM KE WHATSAPP NOCVLA",
                          height: 56,
                          color: MyColors.red,
                          textColor: MyColors.nativeWhite,
                          fontSize: 13.5,
                          fontWeight: .w700,
                          prefixIcon: Icons.chat_bubble_outline,
                          enable: !controller.isPlacingOrder.value,
                          onTap: controller.placeOrder,
                        ),
                        SizedBox(height: 26),
                        MyText(
                          text:
                              "Admin akan membalas dengan total ongkir dan info pembayaran.",
                          fontSize: 12.5,
                          height: 1.6,
                          color: MyColors.white4,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget label(String text, Color color) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w700,
      letterSpacing: 12 * 0.18,
      color: color,
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
