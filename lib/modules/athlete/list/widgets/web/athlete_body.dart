import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/widgets/my_image.dart';
import '../../../../../shared/widgets/my_loading.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_controller.dart';

class AthleteBody extends StatelessWidget {
  const AthleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Obx(() {
      if (controller.isLoadingAthlete.value) return MyLoading();

      if (controller.resAthlete.isEmpty) return SizedBox();

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: .fromLTRB(40, 32, 40, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 4,
          childAspectRatio: 1 / 1.6,
        ),
        itemCount: controller.resAthlete.length,
        itemBuilder: (context, index) {
          // final isLast = index == controller.resAthlete.length;

          // if (isLast) {
          //   return GestureDetector(
          //     onTap: () => null,
          //     child: Container(
          //       decoration: BoxDecoration(color: MyColors.black2),
          //       child: Center(
          //         child: Column(
          //           mainAxisSize: .min,
          //           spacing: 12,
          //           children: [
          //             Icon(Icons.arrow_forward, color: MyColors.white, size: 32),
          //             MyText(
          //               text: "ALL ATHLETES",
          //               fontSize: 20,
          //               fontWeight: .w700,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   );
          // }

          final items = controller.resAthlete[index];

          return GestureDetector(
            onTap: () => controller.openDetail(items.id),
            child: Container(
              decoration: BoxDecoration(color: MyColors.black2),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                spacing: 20,
                children: [
                  Padding(
                    padding: .fromLTRB(4, 4, 4, 0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: MyImage(items.picture, fit: .cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: .symmetric(horizontal: 24, vertical: 12),
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .center,
                        children: [
                          MyText(
                            text: items.name,
                            fontSize: 20,
                            fontWeight: .w600,
                          ),
                          MyText(
                            text: "CODE: ${items.code}",
                            color: MyColors.white2.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
