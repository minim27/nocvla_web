import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/about/about_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/utils/my_linears.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class TAboutHeader extends StatelessWidget {
  const TAboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    final items = controller.res;

    return Stack(
      children: [
        Padding(
          padding: .only(left: 24),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 2820 / 2240,
                child: MyImageAssets(items["image"], scale: 1, fit: .cover),
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
          left: 24,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              MyText(
                text: items["title"],
                fontFamily: MyFonts.bebasNeue,
                fontSize: 48,
                height: 0.9,
                letterSpacing: 2,
                fontWeight: .w500,
              ),
              SizedBox(height: 24),
              MyText(
                text: items["desc"],
                fontSize: 18,
                color: MyColors.white.withValues(alpha: 0.6),
              ),
              SizedBox(height: 42),
              MyButton(
                width: 180,
                "OUR STORY",
                suffix: MyIcons.icForward,
                onTap: () => null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
