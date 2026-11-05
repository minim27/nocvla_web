import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class THomeAthletes extends StatelessWidget {
  const THomeAthletes({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Row(
        spacing: 32,
        children: [
          SizedBox(width: 320, child: image(controller)),
          Expanded(child: info(controller)),
        ],
      ),
    );
  }

  Widget image(HomeController controller) {
    return Obx(() {
      final athletes = controller.resAthlete.toList();

      return Column(
        spacing: 12,
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: athletes.isEmpty
                ? MySkeleton(height: null)
                : PageView.builder(
                    controller: controller.athletePage,
                    itemCount: athletes.length,
                    onPageChanged: controller.onAthleteChanged,
                    itemBuilder: (context, index) {
                      final athlete = athletes[index];

                      return Stack(
                        fit: .expand,
                        children: [
                          MyImage(athlete.picture, alignment: .topCenter),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Container(
                              padding: .symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: MyColors.black,
                                border: .all(color: MyColors.line3),
                              ),
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 2,
                                children: [
                                  MyText(
                                    text: "${athlete.name}".capitalize!,
                                    fontFamily: MyFonts.grenzeGotisch,
                                    fontSize: 20,
                                    fontWeight: .w600,
                                  ),
                                  eyebrow("KODE ATLET: ${athlete.code}"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          if (athletes.length > 1)
            Row(
              mainAxisAlignment: .center,
              children: [
                for (var i = 0; i < athletes.length; i++)
                  GestureDetector(
                    behavior: .opaque,
                    onTap: () => controller.tapAthleteDot(i),
                    child: Container(
                      width: 24,
                      height: 24,
                      alignment: .center,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.athleteIndex.value == i
                              ? MyColors.white
                              : MyColors.swatchBorder,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      );
    });
  }

  Widget info(HomeController controller) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        eyebrow("NOCVLA ATHLETE"),
        SizedBox(height: 12),
        title("They Represent. We Support."),
        SizedBox(height: 16),
        MyText(
          text:
              "Kami mencari individu yang berkomitmen pada disiplin, konsistensi, dan progres tanpa kompromi. Wakili standar yang lebih tinggi bersama NOCVLA.",
          height: 1.6,
          color: MyColors.white,
        ),
        SizedBox(height: 20),
        MyGrid(
          crossAxisCount: 2,
          spacing: 0,
          children: [
            for (final items in controller.resBenefits)
              Container(
                constraints: BoxConstraints(minHeight: 88),
                padding: .all(16),
                decoration: BoxDecoration(border: .all(color: MyColors.line3)),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 6,
                  children: [
                    MyText(
                      text: items["label"],
                      fontFamily: MyFonts.archivoNarrow,
                      fontSize: 13,
                      fontWeight: .w700,
                      letterSpacing: 13 * 0.12,
                    ),
                    MyText(
                      text: items["desc"],
                      fontSize: 12,
                      color: MyColors.white2,
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: MyButton(
                "DAFTAR JADI ATLET",
                onTap: controller.openApplication,
              ),
            ),
            Expanded(
              child: MyButtonBorder(
                "LIHAT ATLET",
                borderColor: MyColors.line2,
                onTap: controller.openAthlete,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget eyebrow(String text, {Color color = MyColors.white2}) {
    return MyText(
      text: text,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w600,
      letterSpacing: 12 * 0.3,
      color: color,
    );
  }

  Widget title(String text) {
    return MyText(
      text: text,
      fontFamily: MyFonts.grenzeGotisch,
      fontSize: 40,
      fontWeight: .w600,
      height: 1.1,
    );
  }
}
