import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(40, 48, 40, 0),
      child: Obx(
        () => GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 4 / 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final items in controller.resCategories)
              category(controller, items),
          ],
        ),
      ),
    );
  }

  Widget category(HomeController controller, Map<String, dynamic> items) {
    final type = items["type"];
    final image = type == null ? null : controller.resTypeImages[type];

    return GestureDetector(
      onTap: () => controller.openCategory(items["type"]),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.black2,
            border: .all(color: MyColors.line),
          ),
          child: Stack(
            fit: .expand,
            children: [
              if (image != null) MyImage(image),
              if (image != null)
                Container(color: MyColors.black.withValues(alpha: 0.45)),
              Padding(
                padding: .all(20),
                child: Column(
                  mainAxisAlignment: .end,
                  crossAxisAlignment: .start,
                  children: [
                    MyText(
                      text: items["label"],
                      fontFamily: MyFonts.grenzeGotisch,
                      fontSize: 36,
                      fontWeight: .w600,
                    ),
                    MyText(text: items["desc"], color: MyColors.white),
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
