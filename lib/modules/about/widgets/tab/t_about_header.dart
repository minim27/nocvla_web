import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class TAboutHeader extends StatelessWidget {
  const TAboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final about = controller.resAbout;
      if (controller.isLoadingAbout.value ||
          [
            "ABOUT_EYEBROW",
            "ABOUT_TITLE",
            "ABOUT_DESCRIPTION",
            "ABOUT_IMAGE",
          ].every((e) => about[e] == null)) {
        return SizedBox();
      }

      return SizedBox(
        height: 640,
        child: Stack(
          fit: .expand,
          children: [
            if (about["ABOUT_IMAGE"] != null)
              MyImage(about["ABOUT_IMAGE"], alignment: .center),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColors.black3.withValues(alpha: 0.9),
                    MyColors.black3.withValues(alpha: 0.55),
                    MyColors.black3.withValues(alpha: 0),
                  ],
                  stops: [0, 0.45, 0.8],
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [
                    MyColors.black3.withValues(alpha: 0),
                    MyColors.black3,
                  ],
                  stops: [0.6, 1],
                ),
              ),
            ),
            Padding(
              padding: .symmetric(horizontal: 40),
              child: Align(
                alignment: .centerLeft,
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    if (about["ABOUT_EYEBROW"] != null) ...[
                      MyText(
                        text: about["ABOUT_EYEBROW"]!.toUpperCase(),
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 12,
                        fontWeight: .w700,
                        letterSpacing: 12 * 0.3,
                        color: MyColors.redText,
                      ),
                      SizedBox(height: 17),
                    ],
                    if (about["ABOUT_TITLE"] != null) ...[
                      MyText(
                        text: about["ABOUT_TITLE"]!,
                        fontFamily: MyFonts.grenzeGotisch,
                        fontSize: 72,
                        fontWeight: .w700,
                        height: 1.0,
                      ),
                      SizedBox(height: 17),
                    ],
                    if (about["ABOUT_DESCRIPTION"] != null)
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 560),
                        child: MyText(
                          text: about["ABOUT_DESCRIPTION"]!,
                          fontSize: 16,
                          height: 1.75,
                          color: MyColors.white3,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
