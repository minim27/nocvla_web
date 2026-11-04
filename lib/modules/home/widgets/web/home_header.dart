import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';
import 'package:nocvla_web/modules/home/home_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_dummies.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_linears.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_divider.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
                    aspectRatio: 2820 / 2240,
                    child: MyImageAssets(
                      MyDummies.dumBanner,
                      scale: 1,
                      fit: .cover,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 2820 / 2240,
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
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  MyText(
                    text: "BUILT DIFFERENT.\nTRAIN NOCVLA.",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 104,
                    height: 0.9,
                    letterSpacing: 2,
                    fontWeight: .w500,
                  ),
                  SizedBox(height: 48),
                  MyText(
                    text:
                        "Performance gear designed for discipline, focus, and progress.",
                    fontSize: 18,
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisSize: .min,
                    spacing: 24,
                    children: [
                      MyButton(
                        width: 217,
                        "SHOP NOW",
                        suffix: MyIcons.icForward,
                        onTap: () => Get.toNamed(MyRoutes.collection),
                      ),
                      MyButtonBorder(
                        width: 217,
                        "VIEW COLLECTION",
                        onTap: () => Get.toNamed(MyRoutes.collection),
                      ),
                    ],
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
            mainAxisAlignment: .spaceEvenly,
            children: .generate(controller.resBenefits["benefits1"].length, (
              index,
            ) {
              final items = controller.resBenefits["benefits1"][index];

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
