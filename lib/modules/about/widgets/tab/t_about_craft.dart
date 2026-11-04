import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class TAboutCraft extends StatelessWidget {
  const TAboutCraft({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Padding(
      padding: .all(40),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          MyText(
            text: "CRAFT",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 36,
            fontWeight: .w600,
          ),
          MyGrid(
            crossAxisCount: 2,
            children: [
              for (final items in controller.res["crafts"])
                Column(
                  crossAxisAlignment: .start,
                  spacing: 4,
                  children: [
                    MyText(text: items["label"], fontWeight: .w600),
                    MyText(text: items["desc"], color: MyColors.white2),
                  ],
                ),
            ],
          ),
          MyButton(
            "LIHAT KOLEKSI",
            width: 240,
            onTap: controller.openCollection,
          ),
        ],
      ),
    );
  }
}
