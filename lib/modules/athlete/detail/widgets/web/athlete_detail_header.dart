import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/widgets/my_loading.dart';
import '../../athlete_detail_controller.dart';

class AthleteDetailHeader extends StatelessWidget {
  const AthleteDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Obx(() {
        if (controller.isLoadingAthlete.value) return MyLoading();

        final items = controller.resAthlete.value;
        if (items == null) return SizedBox();

        return Row(
          crossAxisAlignment: .center,
          spacing: 24,
          children: [
            SizedBox(
              width: 160,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: MyColors.black2,
                  child: MyImage(items.picture, fit: .cover),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                MyText(
                  text: items.name,
                  fontSize: 42,
                  letterSpacing: 2,
                  fontFamily: MyFonts.grenzeGotisch,
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
            ),
          ],
        );
      }),
    );
  }
}
