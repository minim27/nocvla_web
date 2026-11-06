import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class TAboutCta extends StatelessWidget {
  const TAboutCta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final title = controller.resAbout["ABOUT_CTA_TITLE"];
      if (title == null) return SizedBox();

      return Padding(
        padding: .fromLTRB(40, 80, 40, 96),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            MyText(
              text: title,
              fontFamily: MyFonts.grenzeGotisch,
              fontSize: 44,
              fontWeight: .w700,
              height: 1.05,
              textAlign: .center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: .center,
              spacing: 12,
              children: [
                MyButton(
                  "LIHAT KOLEKSI",
                  width: 176,
                  height: 54,
                  fontSize: 14,
                  fontWeight: .w700,
                  onTap: controller.openCollection,
                ),
                MyButtonBorder(
                  "JADI ATLET NOCVLA",
                  width: 219,
                  height: 54,
                  fontSize: 14,
                  fontWeight: .w700,
                  borderColor: MyColors.swatchBorder,
                  onTap: controller.openApplication,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
