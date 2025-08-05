import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/account/password/my_password_controller.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../shared/utils/my_utility.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class MyPasswordPage extends GetView<MyPasswordController> {
  const MyPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          body: Obx(() {
            if (controller.isLoading.value) return MyLoading();

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                MyText(
                  text: "Password",
                  fontSize: 24,
                  fontFamily: MyFonts.libreBaskerville,
                ),
                SizedBox(height: 24),
                Obx(
                  () => MyTextFormField(
                    isPassword: true,
                    obscureText: controller.isOldObscure.value,
                    controller: controller.txtOldPassword,
                    label: "Old Password",
                    labelFontWeight: FontWeight.w500,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    icPassOnTap: () =>
                        changeStatusBool(val: controller.isOldObscure),
                  ),
                ),
                SizedBox(height: 12),
                Obx(
                  () => MyTextFormField(
                    isPassword: true,
                    obscureText: controller.isNewObscure.value,
                    controller: controller.txtNewPassword,
                    label: "New Password",
                    labelFontWeight: FontWeight.w500,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    icPassOnTap: () =>
                        changeStatusBool(val: controller.isNewObscure),
                  ),
                ),
                SizedBox(height: 12),
                Obx(
                  () => MyTextFormField(
                    isPassword: true,
                    obscureText: controller.isConfObscure.value,
                    controller: controller.txtConfPassword,
                    label: "Confirm Password",
                    labelFontWeight: FontWeight.w500,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    icPassOnTap: () =>
                        changeStatusBool(val: controller.isConfObscure),
                  ),
                ),
                SizedBox(height: 32),
                MyButton(text: "Update", onTap: () => controller.updateData()),
              ],
            );
          }),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoadingAction.value,
            child: const MyLoading(isStack: true),
          ),
        ),
      ],
    );
  }
}
