import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../athlete_controller.dart';

class TAthleteBody extends StatelessWidget {
  const TAthleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    if (controller.res.isEmpty) return SizedBox();

    return GridView.builder(
      shrinkWrap: true,
      padding: .fromLTRB(24, 32, 24, 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.3,
      ),
      itemCount: controller.res.length + 1,
      itemBuilder: (context, index) {
        final isLast = index == controller.res.length;

        if (isLast) {
          return GestureDetector(
            onTap: () => null,
            child: Container(
              decoration: BoxDecoration(color: MyColors.black2),
              child: Center(
                child: Column(
                  mainAxisSize: .min,
                  spacing: 12,
                  children: [
                    Icon(Icons.arrow_forward, color: MyColors.white, size: 32),
                    MyText(
                      text: "ALL ATHLETES",
                      fontSize: 20,
                      fontWeight: .w700,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final items = controller.res[index];

        return Container(
          decoration: BoxDecoration(color: MyColors.black2),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            spacing: 20,
            children: [
              AspectRatio(
                aspectRatio: 720 / 500,
                child: MyImageAssets(items["image"], fit: .cover),
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
                        text: items["title"],
                        fontSize: 20,
                        fontWeight: .w600,
                      ),
                      MyText(
                        text: items["subTitle"],
                        fontSize: 16,
                        fontWeight: .w500,
                      ),
                      MyText(
                        text: (items["isComingSoon"])
                            ? "Coming Soon"
                            : "${items["count"]} Athletes",
                        color: MyColors.white2.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
