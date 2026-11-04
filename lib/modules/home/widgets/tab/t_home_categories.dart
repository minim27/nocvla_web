import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_images.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(40, 40, 40, 0),
      child: Obx(
        () => Row(
          spacing: 16,
          children: [
            for (final items in controller.resCategories)
              Expanded(child: category(controller, items)),
          ],
        ),
      ),
    );
  }

  Widget category(HomeController controller, Map<String, dynamic> items) {
    final type = items["type"];
    final image = type == null ? null : controller.resTypeImages[type];

    return GestureDetector(
      onTap: () => controller.openCategory(type),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.black5,
            border: .all(color: MyColors.line3),
          ),
          child: Stack(
            fit: .expand,
            children: [
              if (image != null) ...[
                MyImage(image),
                Container(color: MyColors.black.withValues(alpha: 0.5)),
              ] else
                Padding(
                  padding: .fromLTRB(60, 16, 60, 56),
                  child: Opacity(
                    opacity: 0.2,
                    child: MyImageAssets(MyImages.imgNocvla, fit: .contain),
                  ),
                ),
              Padding(
                padding: .all(20),
                child: Column(
                  mainAxisAlignment: .end,
                  crossAxisAlignment: .start,
                  children: [
                    MyText(
                      text: items["label"],
                      fontFamily: MyFonts.grenzeGotisch,
                      fontSize: 28,
                      fontWeight: .w600,
                    ),
                    MyText(
                      text: items["desc"],
                      fontFamily: MyFonts.archivoNarrow,
                      fontSize: 12,
                      fontWeight: .w600,
                      letterSpacing: 12 * 0.12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
