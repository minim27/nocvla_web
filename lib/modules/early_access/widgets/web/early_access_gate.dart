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

class EarlyAccessGate extends GetView<EarlyAccessController> {
  const EarlyAccessGate({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Get.find<MainLayoutController>();

    return Obx(() {
      final content = controller.resContent;

      return Stack(
        fit: .expand,
        children: [
          if (content["EARLY_ACCESS_IMAGE"] != null) ...[
            MyImage(content["EARLY_ACCESS_IMAGE"], fit: .cover),
            Container(color: MyColors.black3.withValues(alpha: 0.8)),
          ],
          ListView(
            padding: .symmetric(horizontal: 40, vertical: 72),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 820),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 170,
                        height: 56,
                        child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
                      ),
                      SizedBox(height: 40),
                      if (content["EARLY_ACCESS_EYEBROW"] != null) ...[
                        MyText(
                          text: content["EARLY_ACCESS_EYEBROW"]!.toUpperCase(),
                          fontFamily: MyFonts.archivoNarrow,
                          fontSize: 12,
                          fontWeight: .w700,
                          letterSpacing: 12 * 0.3,
                          color: MyColors.redText,
                          textAlign: .center,
                        ),
                        SizedBox(height: 14),
                      ],
                      if (content["EARLY_ACCESS_TITLE"] != null) ...[
                        MyText(
                          text: content["EARLY_ACCESS_TITLE"]!,
                          fontFamily: MyFonts.grenzeGotisch,
                          fontSize: 84,
                          fontWeight: .w700,
                          height: 1.05,
                          textAlign: .center,
                        ),
                        SizedBox(height: 12),
                      ],
                      if (content["EARLY_ACCESS_DESCRIPTION"] != null)
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 460),
                          child: MyText(
                            text: content["EARLY_ACCESS_DESCRIPTION"]!,
                            fontSize: 15.5,
                            height: 1.7,
                            color: MyColors.white3,
                            textAlign: .center,
                          ),
                        ),
                      SizedBox(height: 32),
                      countdown(controller.remaining.value),
                      SizedBox(height: 38),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 460),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            MyText(
                              text: "KATA SANDI EARLY ACCESS",
                              fontFamily: MyFonts.archivoNarrow,
                              fontSize: 12,
                              fontWeight: .w700,
                              letterSpacing: 12 * 0.18,
                            ),
                            SizedBox(height: 11),
                            Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: MyTextFormField(
                                    controller: controller.passwordController,
                                    hintText: "Masukkan kata sandi",
                                    isPassword: true,
                                    textInputAction: .done,
                                    fontSize: 14,
                                    fillColor: MyColors.black3,
                                    borderColor: MyColors.swatchBorder,
                                    hintColor: MyColors.placeholder,
                                    padding: .symmetric(
                                      horizontal: 16,
                                      vertical: 17,
                                    ),
                                    onFieldSubmitted: (_) =>
                                        controller.submitPassword(),
                                  ),
                                ),
                                MyButton(
                                  "MASUK",
                                  width: 96,
                                  height: 52,
                                  fontSize: 13,
                                  fontWeight: .w700,
                                  enable: !controller.isSubmitting.value,
                                  onTap: controller.submitPassword,
                                ),
                              ],
                            ),
                            if (layout.linkDiscord.value.isNotEmpty) ...[
                              SizedBox(height: 12),
                              GestureDetector(
                                behavior: .opaque,
                                onTap: layout.openDiscordLink,
                                child: MyText(
                                  text:
                                      "Belum punya kata sandi? Gabung Discord NOCVLA",
                                  fontSize: 13,
                                  color: MyColors.white2,
                                  decoration: .underline,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (controller.images.isNotEmpty) ...[
                        SizedBox(height: 40),
                        MyGrid(
                          crossAxisCount: 4,
                          spacing: 14,
                          children: [
                            for (final image in controller.images)
                              Container(
                                decoration: BoxDecoration(
                                  border: .all(color: MyColors.line2),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 4 / 5,
                                  child: ClipRect(
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                        sigmaX: 12,
                                        sigmaY: 12,
                                      ),
                                      child: MyImage(image.imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget countdown(Duration remaining) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 12,
      children: [
        unit(remaining.inDays, "HARI"),
        unit(remaining.inHours % 24, "JAM"),
        unit(remaining.inMinutes % 60, "MENIT"),
        unit(remaining.inSeconds % 60, "DETIK"),
      ],
    );
  }

  Widget unit(int value, String label) {
    return Container(
      width: 130,
      height: 113,
      decoration: BoxDecoration(
        color: MyColors.black3.withValues(alpha: 0.6),
        border: .all(color: MyColors.line2),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          MyText(
            text: value.toString().padLeft(2, "0"),
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 44,
            fontWeight: .w700,
            height: 1.1,
          ),
          SizedBox(height: 4),
          MyText(
            text: label,
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 11,
            fontWeight: .w600,
            letterSpacing: 11 * 0.2,
            color: MyColors.white2,
          ),
        ],
      ),
    );
  }
}
