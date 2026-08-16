import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/widgets/my_athlete_card.dart';
import '../../../../../shared/widgets/my_loading.dart';
import '../../athlete_controller.dart';

class TAthleteBody extends StatelessWidget {
  const TAthleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Obx(() {
      if (controller.isLoadingAthlete.value) return MyLoading();

      if (controller.resAthlete.isEmpty) return SizedBox();

      return LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisCount = 3;
          const crossAxisSpacing = 16.0;
          const horizontalPadding = 24.0;
          const textAreaHeight = 90.0;
          final columnWidth =
              (constraints.maxWidth -
                  horizontalPadding * 2 -
                  crossAxisSpacing * (crossAxisCount - 1)) /
              crossAxisCount;

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: .fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: 16,
              crossAxisCount: crossAxisCount,
              mainAxisExtent: columnWidth + textAreaHeight,
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

              return MyAthleteCard(
                item: items,
                onTap: () => controller.openDetail(items.id),
              );
            },
          );
        },
      );
    });
  }
}
