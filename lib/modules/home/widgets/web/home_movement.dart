import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/home/home_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_dummies.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_linears.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class HomeMovement extends StatelessWidget {
  const HomeMovement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: .only(left: 250),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 2820 / 850,
                    child: MyImageAssets(
                      MyDummies.dumMovement,
                      alignment: .topCenter,
                      scale: 1,
                      fit: .cover,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 2820 / 850,
                    child: Container(
                      decoration: BoxDecoration(gradient: MyLinears.linear1),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 190,
              top: 0,
              bottom: 0,
              child: Column(
                spacing: 56,
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  MyText(
                    text: "DISCIPLINE TODAY.\nSTRENGTH TOMORROW.",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 72,
                    height: 0.9,
                    letterSpacing: 1,
                  ),
                  MyButton(width: 221, "JOIN THE MOVEMENT", onTap: () => null),
                ],
              ),
            ),
          ],
        ),
        MyDivider(),
        Padding(
          padding: .all(48),
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children: .generate(controller.resBenefits["benefits2"].length, (
              index,
            ) {
              final items = controller.resBenefits["benefits2"][index];

              return Row(
                spacing: 24,
                children: [
                  MyImageAssets(items["icon"]),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      MyText(
                        text: items["label"],
                        fontSize: 20,
                        fontWeight: .w600,
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: MyText(
                          text: items["desc"],
                          fontSize: 16,
                          color: MyColors.white2,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
        MyDivider(),
      ],
    );
  }
}
