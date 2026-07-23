import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/about/about_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class MAboutTarget extends StatelessWidget {
  const MAboutTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Padding(
      padding: .all(48),
      child: Column(
        spacing: 32,
        mainAxisAlignment: .spaceBetween,
        children: .generate(controller.res["targets"].length, (index) {
          final items = controller.res["targets"][index];

          return Column(
            spacing: 8,
            children: [
              MyImageAssets(items["icon"]),
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
          );
        }),
      ),
    );
  }
}
