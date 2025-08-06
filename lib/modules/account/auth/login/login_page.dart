import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';

import '../../../../shared/utils/my_images.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: MyImageAssets(assets: MyImages.imgNocvla),
                    ),
                    SizedBox(height: 24),
                    MyTextFormField(
                      controller: controller.txtEmail,
                      label: "Email",
                      labelFontWeight: FontWeight.w500,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 12),
                    Obx(
                      () => MyTextFormField(
                        isPassword: true,
                        obscureText: controller.isObscure.value,
                        controller: controller.txtPassword,
                        label: "Password",
                        labelFontWeight: FontWeight.w500,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        icPassOnTap: () =>
                            changeStatusBool(val: controller.isObscure),
                      ),
                    ),
                    SizedBox(height: 32),
                    MyButton(text: "Login", onTap: () => controller.login()),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoading.value,
            child: const MyLoading(isStack: true),
          ),
        ),
      ],
    );
  }
}
