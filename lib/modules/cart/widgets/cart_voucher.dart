import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/cart/cart_controller.dart';

import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class CartVoucher extends StatelessWidget {
  const CartVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Expanded(
      child: Padding(
        padding: .only(top: 36),
        child: Row(
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
              child: MyButton(
                "APPLY",
                width: 120,
                height: 52,
                onTap: () => null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
