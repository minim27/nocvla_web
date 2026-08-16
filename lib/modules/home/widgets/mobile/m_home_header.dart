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

class MHomeHeader extends StatelessWidget {
  const MHomeHeader({super.key});

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
            Positioned(
              left: 24,
              right: 24,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  MyText(
                    text: "BUILT DIFFERENT.\nTRAIN NOCVLA.",
                    fontFamily: MyFonts.bebasNeue,
                    fontSize: 30,
                    height: 0.9,
                    letterSpacing: 2,
                    fontWeight: .w500,
                  ),
                  SizedBox(height: 16),
                  MyText(
                    text:
                        "Performance gear designed for discipline, focus, and progress.",
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 24),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: MyButton(
                          height: 42,
                          "SHOP NOW",
                          suffix: MyIcons.icForward,
                          onTap: () => Get.toNamed(MyRoutes.collection),
                        ),
                      ),
                      Expanded(
                        child: MyButtonBorder(
                          height: 44,
                          "VIEW COLLECTION",
                          onTap: () => Get.toNamed(MyRoutes.collection),
                        ),
                      ),
                    ],
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
            childAspectRatio: 1.5,
          ),
          itemCount: controller.resBenefits["benefits1"].length,
          itemBuilder: (context, index) {
            final items = controller.resBenefits["benefits1"][index];

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
