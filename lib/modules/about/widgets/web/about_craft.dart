import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class AboutCraft extends StatelessWidget {
  const AboutCraft({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final about = controller.resAbout;
      final crafts = controller.crafts;
      if (about["ABOUT_CRAFT_TITLE"] == null && crafts.isEmpty) {
        return SizedBox();
      }

      return Container(
        margin: .only(top: 112),
        decoration: BoxDecoration(
          color: MyColors.black4,
          border: Border.symmetric(
            horizontal: BorderSide(color: MyColors.line2),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
            child: Padding(
              padding: .fromLTRB(48, 96, 48, 96),
              child: SizedBox(
                width: .infinity,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    if (about["ABOUT_CRAFT_EYEBROW"] != null) ...[
                      MyText(
                        text: about["ABOUT_CRAFT_EYEBROW"]!.toUpperCase(),
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 12,
                        fontWeight: .w700,
                        letterSpacing: 12 * 0.3,
                        color: MyColors.white2,
                      ),
                      SizedBox(height: 14),
                    ],
                    if (about["ABOUT_CRAFT_TITLE"] != null) ...[
                      MyText(
                        text: about["ABOUT_CRAFT_TITLE"]!,
                        fontFamily: MyFonts.grenzeGotisch,
                        fontSize: 54,
                        fontWeight: .w700,
                        height: 1.0,
                      ),
                      SizedBox(height: 36),
                    ],
                    if (crafts.isNotEmpty)
                      MyGrid(
                        crossAxisCount: 4,
                        children: [for (final item in crafts) card(item)],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget card((String, String) item) {
    return Container(
      padding: .fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: MyColors.black3,
        border: .all(color: MyColors.line2),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          if (item.$1.isNotEmpty)
            MyText(
              text: item.$1.toUpperCase(),
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 14,
              fontWeight: .w700,
              letterSpacing: 14 * 0.12,
            ),
          if (item.$1.isNotEmpty && item.$2.isNotEmpty) SizedBox(height: 6),
          if (item.$2.isNotEmpty)
            MyText(
              text: item.$2,
              fontSize: 13.6,
              height: 1.62,
              color: MyColors.white2,
            ),
        ],
      ),
    );
  }
}
