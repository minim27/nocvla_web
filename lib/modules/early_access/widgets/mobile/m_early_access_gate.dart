import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/main_layout/main_layout_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_images.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_grid.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../../early_access_controller.dart';

class MEarlyAccessGate extends GetView<EarlyAccessController> {
  const MEarlyAccessGate({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Get.find<MainLayoutController>();

    return ListView(
      padding: .symmetric(horizontal: 24, vertical: 40),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 640),
            child: Column(
              spacing: 24,
              children: [
                SizedBox(
                  width: 165,
                  height: 56,
                  child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
                ),
                Obx(() => countdown(controller.remaining.value)),
                MyTextFormField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  isPassword: true,
                  textInputAction: .done,
                  onFieldSubmitted: (_) => controller.submitPassword(),
                ),
                Obx(
                  () => MyButton(
                    "MASUK",
                    width: .infinity,
                    enable: !controller.isSubmitting.value,
                    onTap: controller.submitPassword,
                  ),
                ),
                Obx(() {
                  if (layout.linkDiscord.value.isEmpty) return SizedBox();

                  return MyButtonBorder(
                    "GABUNG DISCORD",
                    width: .infinity,
                    borderColor: MyColors.white,
                    onTap: layout.openDiscordLink,
                  );
                }),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        Obx(
          () => ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: MyGrid(
              crossAxisCount: 2,
              children: [
                for (final image in controller.images)
                  AspectRatio(aspectRatio: 1, child: MyImage(image.imageUrl)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget countdown(Duration remaining) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 16,
      children: [
        unit(remaining.inDays, "Hari"),
        unit(remaining.inHours % 24, "Jam"),
        unit(remaining.inMinutes % 60, "Menit"),
        unit(remaining.inSeconds % 60, "Detik"),
      ],
    );
  }

  Widget unit(int value, String label) {
    return Column(
      children: [
        MyText(
          text: value.toString().padLeft(2, "0"),
          fontFamily: MyFonts.grenzeGotisch,
          fontSize: 30,
          fontWeight: .w600,
        ),
        MyText(text: label, fontSize: 12, color: MyColors.white2),
      ],
    );
  }
}
