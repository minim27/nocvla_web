import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../../../shared/widgets/my_text_form_field.dart';

class CartVoucher extends StatelessWidget {
  const CartVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Expanded(
      child: Padding(
        padding: .only(top: 36),
        child: Column(
          crossAxisAlignment: .end,
          spacing: 12,
          children: [
            Row(
              mainAxisAlignment: .end,
              crossAxisAlignment: .end,
              children: [
                Flexible(
                  child: MyTextFormField(
                    label: "HAVE A ATHLETE CODE",
                    width: 300,
                    height: 48,
                    controller: controller.txtCode,
                    hintText: "Masukkan Kode",
                    textInputAction: .send,
                    keyboardType: .text,
                    textAlign: .left,
                  ),
                ),
                Padding(
                  padding: .only(bottom: 2),
                  child: Obx(
                    () => MyButton(
                      "APPLY",
                      width: 120,
                      height: 52,
                      enable: !controller.isValidatingCode.value,
                      onTap: () => controller.applyCode(),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              final code = controller.appliedCode.value;
              if (code == null) return SizedBox();

              return Container(
                padding: .symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: MyColors.black2,
                  border: .all(color: MyColors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisSize: .min,
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 14,
                      color: MyColors.white2,
                    ),
                    MyText(text: code, fontSize: 14, fontWeight: .w600),
                    GestureDetector(
                      behavior: .opaque,
                      onTap: () => controller.removeCode(),
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: MyColors.white2,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
