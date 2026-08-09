import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../early_access_controller.dart';

class EarlyAccessPasswordDialog extends GetView<EarlyAccessController> {
  const EarlyAccessPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MyColors.black2,
      insetPadding: .symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: .all(24),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            spacing: 16,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: "Enter store using password:",
                      fontSize: 18,
                      fontWeight: .w600,
                    ),
                  ),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: MyColors.white2, size: 20),
                  ),
                ],
              ),
              MyTextFormField(
                controller: controller.passwordController,
                hintText: "Your password",
                obscureText: true,
                textInputAction: .done,
                onFieldSubmitted: (_) => controller.submitPassword(),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.isSubmitting.value
                      ? null
                      : controller.submitPassword,
                  child: Container(
                    height: 48,
                    alignment: .center,
                    color: MyColors.white,
                    child: controller.isSubmitting.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: MyColors.black,
                            ),
                          )
                        : MyText(
                            text: "Enter",
                            color: MyColors.black,
                            fontWeight: .w600,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
