import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../shared/utils/my_dummies.dart';
import '../../../../shared/utils/my_linears.dart';
import '../../../../shared/widgets/my_divider.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../athlete_controller.dart';

class MAthleteBottom extends StatelessWidget {
  const MAthleteBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Column(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 2590 / 890,
                  child: MyImageAssets(
                    MyDummies.dumMovement,
                    alignment: .topCenter,
                    scale: 1,
                    fit: .cover,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 2590 / 890,
                  child: Container(
                    decoration: BoxDecoration(gradient: MyLinears.linear1),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 24,
              top: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  MyText(
                    text: "JOIN NOCVLA ATHLETE",
                    fontWeight: .w600,
                    fontFamily: MyFonts.bebasNeue,
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                  MyText(
                    text:
                        "Kami mencari individu yang berkomitmen pada disiplin,\nkonsistensi, dan progres tanpa kompromi.\nBergabunglah menjadi bagian dari NOCVLA Athlete\ndan representasikan standar yang lebih tinggi.",
                    color: MyColors.white.withValues(alpha: 0.6),
                  ),
                  SizedBox(height: 16),
                  MyButton(
                    width: 180,
                    height: 42,
                    "JOIN NOW",
                    onTap: () => null,
                  ),
                ],
              ),
            ),
          ],
        ),
        MyDivider(),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
          itemCount: controller.resBenefits.length,
          itemBuilder: (context, index) {
            final items = controller.resBenefits[index];

            return Column(
              mainAxisAlignment: .center,
              spacing: 16,
              children: [
                MyImageAssets(items["icon"]),
                Column(
                  spacing: 4,
                  crossAxisAlignment: .center,
                  children: [
                    MyText(
                      text: items["label"],
                      fontSize: 16,
                      fontWeight: .w600,
                      textAlign: .center,
                    ),
                    Opacity(
                      opacity: 0.6,
                      child: MyText(
                        text: items["desc"],
                        color: MyColors.white2,
                        textAlign: .center,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        MyDivider(),
      ],
    );
  }
}
