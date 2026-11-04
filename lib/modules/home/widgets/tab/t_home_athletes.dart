import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_athlete_card.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class THomeAthletes extends StatelessWidget {
  const THomeAthletes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 32,
        children: [
          MyText(
            text: "THE CONGREGATION",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 40,
            fontWeight: .w600,
          ),
          Obx(
            () => MyGrid(
              crossAxisCount: 3,
              children: [
                for (final items in controller.resAthlete.take(3))
                  MyAthleteCard(
                    item: items,
                    onTap: () => controller.openAthleteDetail(items.id),
                  ),
              ],
            ),
          ),
          MyGrid(
            crossAxisCount: 2,
            children: [
              for (final items in controller.resBenefits)
                Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    MyImageAssets(items["icon"], alignment: .centerLeft),
                    MyText(text: items["label"], fontWeight: .w600),
                    MyText(text: items["desc"], color: MyColors.white2),
                  ],
                ),
            ],
          ),
          MyButtonBorder(
            "DAFTAR JADI ATLET",
            width: 240,
            borderColor: MyColors.white,
            onTap: controller.openAthlete,
          ),
        ],
      ),
    );
  }
}
