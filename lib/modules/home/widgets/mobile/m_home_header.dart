import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class MHomeHeader extends StatelessWidget {
  const MHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SizedBox(
      height: 480,
      child: Stack(
        fit: .expand,
        children: [
          Obx(() {
            final image = controller.heroImage;

            return image == null
                ? MySkeleton(height: null)
                : MyImage(image, alignment: .topCenter);
          }),
          Container(color: MyColors.black.withValues(alpha: 0.55)),
          Padding(
            padding: .symmetric(horizontal: 24),
            child: Obx(
              () => Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  MyText(
                    text: controller.heroTitle,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 40,
                    fontWeight: .w600,
                    height: 1,
                  ),
                  MyText(
                    text: controller.heroDesc,
                    fontSize: 16,
                    color: MyColors.white,
                  ),
                  SizedBox(height: 8),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: MyButton(
                          "LIHAT KOLEKSI",
                          onTap: controller.openCollection,
                        ),
                      ),
                      Expanded(
                        child: MyButtonBorder(
                          "ATLET KAMI",
                          borderColor: MyColors.white,
                          onTap: controller.openAthlete,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
