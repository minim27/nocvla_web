import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_athlete_card.dart';
import '../../../../../shared/widgets/my_grid.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_controller.dart';

class AthleteBody extends StatelessWidget {
  const AthleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Padding(
      padding: .all(40),
      child: Obx(() {
        if (controller.isLoadingAthlete.value) {
          return MyGrid(
            crossAxisCount: 4,
            children: [
              for (var i = 0; i < 4; i++)
                AspectRatio(aspectRatio: 1, child: MySkeleton(height: null)),
            ],
          );
        }

        return MyGrid(
          crossAxisCount: 4,
          children: [
            for (final items in controller.resAthlete)
              MyAthleteCard(
                item: items,
                onTap: () => controller.openDetail(items.id),
                onCopy: () => controller.copyCode(items.code),
              ),
            GestureDetector(
              onTap: controller.openApplication,
              child: Container(
                constraints: BoxConstraints(minHeight: 200),
                alignment: .center,
                padding: .all(16),
                decoration: BoxDecoration(border: .all(color: MyColors.line)),
                child: Column(
                  mainAxisSize: .min,
                  spacing: 8,
                  children: [
                    MyText(
                      text: "YOUR NAME HERE",
                      textAlign: .center,
                      fontFamily: MyFonts.grenzeGotisch,
                      fontSize: 28,
                      fontWeight: .w600,
                    ),
                    MyText(
                      text: "Daftar jadi atlet",
                      textAlign: .center,
                      color: MyColors.white2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
