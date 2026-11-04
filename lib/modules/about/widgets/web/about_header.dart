import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(
          height: 480,
          child: Stack(
            fit: .expand,
            children: [
              Obx(
                () => controller.heroImage.value == null
                    ? MySkeleton(height: null)
                    : MyImage(
                        controller.heroImage.value,
                        alignment: .topCenter,
                      ),
              ),
              Container(color: MyColors.black.withValues(alpha: 0.55)),
              Padding(
                padding: .all(40),
                child: Align(
                  alignment: .bottomLeft,
                  child: MyText(
                    text: controller.res["title"],
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 64,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: .all(40),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [
              MyText(
                text: "OUR STORY",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 40,
                fontWeight: .w600,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 760),
                child: MyText(
                  text: controller.res["story"],
                  fontSize: 16,
                  height: 1.6,
                  color: MyColors.white2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
