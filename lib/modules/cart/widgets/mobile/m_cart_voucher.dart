import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_panel.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import '../../cart_controller.dart';

class MCartVoucher extends StatelessWidget {
  const MCartVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return MyPanel(
      child: Obx(
        () => Column(
          crossAxisAlignment: .stretch,
          spacing: 12,
          children: [
            MyTextFormField(
              controller: controller.txtCode,
              label: "KODE ATLET",
              hintText: "Masukkan kode",
              onFieldSubmitted: (_) => controller.applyCode(),
            ),
            MyButtonBorder(
              "PAKAI KODE",
              enable: !controller.isValidatingCode.value,
              onTap: controller.applyCode,
            ),
            if (controller.appliedCode.value != null)
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: "Kode ${controller.appliedCode.value} terpasang",
                      color: MyColors.green,
                    ),
                  ),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: controller.removeCode,
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.close,
                        color: MyColors.white2,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
