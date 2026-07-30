import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/widgets/my_loading.dart';
import '../../athlete_detail_controller.dart';

class MAthleteDetailHeader extends StatelessWidget {
  const MAthleteDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Padding(
      padding: .fromLTRB(24, 80, 24, 0),
      child: Obx(() {
        if (controller.isLoadingAthlete.value) return MyLoading();

        final items = controller.resAthlete.value;
        if (items == null) return SizedBox();

        return Column(
          crossAxisAlignment: .start,
          spacing: 16,
          children: [
            AspectRatio(
              aspectRatio: 720 / 500,
              child: Container(
                color: MyColors.black2,
                child: MyImage(items.picture, fit: .cover),
              ),
            ),
            MyText(
              text: items.name,
              fontSize: 42,
              letterSpacing: 2,
              fontFamily: MyFonts.bebasNeue,
            ),
            Row(
              spacing: 8,
              children: [
                MyText(
                  text: "CODE: ${items.code}",
                  fontSize: 16,
                  color: MyColors.white2,
                ),
                GestureDetector(
                  onTap: controller.copyCode,
                  child: Icon(Icons.copy, size: 16, color: MyColors.white2),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
