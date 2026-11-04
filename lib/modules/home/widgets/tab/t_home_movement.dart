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

class THomeMovement extends StatelessWidget {
  const THomeMovement({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      children: [
        Stack(
          children: [
            Stack(
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
            Positioned(
              left: 24,
              top: 0,
              bottom: 0,
              child: Column(
                spacing: 16,
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  MyText(
                    text: "DISCIPLINE TODAY.\nSTRENGTH TOMORROW.",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 36,
                    height: 0.9,
                    letterSpacing: 1,
                  ),
                  MyButton(width: 180, "JOIN THE MOVEMENT", onTap: () => null),
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
          itemCount: controller.resBenefits["benefits2"].length,
          itemBuilder: (context, index) {
            final items = controller.resBenefits["benefits2"][index];

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
                      fontSize: 18,
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
              ],
            );
          },
        ),
        MyDivider(),
      ],
    );
  }
}
