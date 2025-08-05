import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/account/my_profile/my_profile_controller.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_image.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          appBar: AppBar(
            title: SizedBox(
              width: 70,
              child: MyImageAssets(assets: MyImages.imgNocvla),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            if (controller.isLoading.value) return MyLoading();

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                MyText(
                  text: "Profile",
                  fontSize: 24,
                  fontFamily: MyFonts.libreBaskerville,
                ),
                SizedBox(height: 24),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        controller: controller.txtFirstName,
                        label: "First Name",
                        labelFontWeight: FontWeight.w500,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Expanded(
                      child: MyTextFormField(
                        controller: controller.txtLastName,
                        label: "Last Name",
                        labelFontWeight: FontWeight.w500,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                MyTextFormField(
                  controller: controller.txtEmail,
                  label: "Email",
                  labelFontWeight: FontWeight.w500,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 12),
                MyTextFormField(
                  controller: controller.txtPhone,
                  label: "Phone",
                  labelFontWeight: FontWeight.w500,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
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
