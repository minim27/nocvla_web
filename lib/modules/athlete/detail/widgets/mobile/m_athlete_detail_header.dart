import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_button.dart';
import '../../../../../shared/widgets/my_image.dart';
import '../../../../../shared/widgets/my_skeleton.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_detail_controller.dart';

class MAthleteDetailHeader extends StatelessWidget {
  const MAthleteDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line2)),
      ),
      child: Padding(
        padding: .fromLTRB(24, 32, 24, 32),
        child: Obx(() {
          if (controller.isLoadingAthlete.value) {
            return MySkeleton(height: 400);
          }

          final items = controller.resAthlete.value;
          if (items == null) return SizedBox();

          return Column(
            crossAxisAlignment: .stretch,
            spacing: 24,
            children: [
              AspectRatio(
                aspectRatio: 4 / 5,
                child: MyImage(items.picture, alignment: .topCenter),
              ),
              Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(
                    text: "NOCVLA ATHLETE",
                    fontFamily: MyFonts.archivoNarrow,
                    fontSize: 12,
                    fontWeight: .w600,
                    letterSpacing: 12 * 0.3,
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 12),
                  MyText(
                    text: "${items.name}".capitalize!,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 46,
                    fontWeight: .w700,
                    height: 1.05,
                  ),
                  SizedBox(height: 12),
                  MyText(
                    text: "Kode atlet: ${items.code}",
                    fontSize: 15,
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 24),
                  MyButtonBorder(
                    "SALIN KODE",
                    borderColor: MyColors.line2,

                    onTap: controller.copyCode,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
