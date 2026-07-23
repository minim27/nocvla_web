import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/about/about_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class AboutTarget extends StatelessWidget {
  const AboutTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Padding(
      padding: .all(48),
      child: Row(
        children: List.generate(controller.res["targets"].length, (index) {
          final items = controller.res["targets"][index];

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

                if (index != controller.res["targets"].length - 1)
                  Container(
                    margin: .symmetric(horizontal: 32),
                    width: 1,
                    height: 80,
                    color: MyColors.white.withValues(alpha: 0.1),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
