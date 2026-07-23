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

class AthleteBottom extends StatelessWidget {
  const AthleteBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: .only(left: 250),
              child: Stack(
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
            ),
            Positioned(
              left: 40,
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
                    fontSize: 48,
                    letterSpacing: 2,
                  ),
                  MyText(
                    text:
                        "Kami mencari individu yang berkomitmen pada disiplin,\nkonsistensi, dan progres tanpa kompromi.\nBergabunglah menjadi bagian dari NOCVLA Athlete\ndan representasikan standar yang lebih tinggi.",
                    color: MyColors.white.withValues(alpha: 0.6),
                  ),
                  SizedBox(height: 30),
                  MyButton(
                    width: 140,
                    height: 48,
                    "JOIN NOW",
                    onTap: () => null,
                  ),
                ],
              ),
            ),
          ],
        ),
        MyDivider(),
        Padding(
          padding: .all(48),
          child: Row(
            children: List.generate(controller.resBenefits.length, (index) {
              final items = controller.resBenefits[index];

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 8,
                        children: [
                          MyImageAssets(items["icon"]),
                          MyText(
                            text: items["label"],
                            fontSize: 20,
                            fontWeight: .w600,
                            textAlign: .center,
                          ),
                          Opacity(
                            opacity: 0.6,
                            child: MyText(
                              text: items["desc"],
                              fontSize: 16,
                              color: MyColors.white2,
                              textAlign: .center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (index != controller.resBenefits.length - 1)
                      Container(
                        margin: .symmetric(horizontal: 32),
                        width: 1,
                        height: 180,
                        color: MyColors.white.withValues(alpha: 0.1),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
        MyDivider(),
      ],
    );
  }
}
