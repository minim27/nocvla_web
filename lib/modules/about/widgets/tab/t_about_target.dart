import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_panel.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class TAboutTarget extends StatelessWidget {
  const TAboutTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Padding(
      padding: .symmetric(horizontal: 40),
      child: MyGrid(
        crossAxisCount: 3,
        children: [
          for (final items in controller.res["targets"])
            MyPanel(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  MyImageAssets(items["icon"], alignment: .centerLeft),
                  MyText(text: items["label"], fontWeight: .w600),
                  MyText(text: items["desc"], color: MyColors.white2),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
