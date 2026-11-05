import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_athlete_card.dart';
import '../../../../../shared/widgets/my_dash_border.dart';
import '../../../../../shared/widgets/my_grid.dart';
import '../../../../../shared/widgets/my_max_width.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_controller.dart';

class AthleteBody extends StatelessWidget {
  const AthleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return MyMaxWidth(
      child: Padding(
        padding: .only(top: 32, bottom: 112),
        child: Obx(() {
          if (controller.isLoadingAthlete.value) {
            return MyGrid(
              crossAxisCount: 4,
              children: [
                for (var i = 0; i < 4; i++)
                  AspectRatio(
                    aspectRatio: 2 / 3,
                    child: MySkeleton(height: null),
                  ),
              ],
            );
          }

          return MyGrid(
            crossAxisCount: 4,
            children: [
              for (final items in controller.resAthlete)
                MyAthleteCard(
                  item: items,
                  nameFontSize: 29.5,
                  onTap: () => controller.openDetail(items.id),
                  onCopy: () => controller.copyCode(items.code),
                ),
              slot(controller),
            ],
          );
        }),
      ),
    );
  }

  Widget slot(AthleteController controller) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height:
            (constraints.maxWidth - 2) / MyAthleteCard.photoRatio +
            MyAthleteCard.contentHeight +
            2,
        child: MyDashBorder(
          child: Padding(
            padding: .all(20),
            child: Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  MyText(
                    text: "Your name here",
                    color: MyColors.nativeWhite,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 33,
                    fontWeight: .w600,
                    height: 1.1,
                    textAlign: .center,
                  ),
                  SizedBox(height: 13),
                  MyText(
                    text: "Slot terbuka untuk atlet berikutnya.",
                    fontSize: 13.5,
                    color: MyColors.white2,
                    textAlign: .center,
                  ),
                  SizedBox(height: 13),
                  GestureDetector(
                    behavior: .opaque,
                    onTap: controller.scrollToForm,
                    child: Container(
                      padding: .only(bottom: 3),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: MyColors.white),
                        ),
                      ),
                      child: MyText(
                        text: "DAFTAR SEKARANG",
                        color: MyColors.nativeWhite,
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 12.8,
                        fontWeight: .w700,
                        letterSpacing: 12.8 * 0.17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
