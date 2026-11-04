import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_accordion.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_panel.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../contact_controller.dart';

class MContactSosmed extends StatelessWidget {
  const MContactSosmed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();

    return Padding(
      padding: .all(24),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 32,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              MyText(
                text: "KONTAK",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 44,
                fontWeight: .w600,
              ),
              MyText(
                text: "Hubungi kami lewat salah satu kanal berikut.",
                fontSize: 16,
                color: MyColors.white2,
              ),
            ],
          ),
          MyGrid(
            crossAxisCount: 1,
            children: [
              for (final items in controller.res)
                GestureDetector(
                  onTap: () => controller.open(items["link"]),
                  child: MyPanel(
                    child: Row(
                      spacing: 12,
                      children: [
                        MyImageAssets(items["icon"]),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              MyText(text: items["label"], fontWeight: .w600),
                              MyText(
                                text: items["desc"],
                                fontSize: 13,
                                color: MyColors.white2,
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          MyText(
            text: "FAQ",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 32,
            fontWeight: .w600,
          ),
          Column(
            children: [
              for (final items in controller.resFaq)
                MyAccordion(
                  title: items["question"]!,
                  child: MyText(text: items["answer"]!, color: MyColors.white2),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
