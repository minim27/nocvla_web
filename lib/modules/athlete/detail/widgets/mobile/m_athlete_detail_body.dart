import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_parsing_currency.dart';
import '../../../../../shared/widgets/my_image.dart';
import '../../../../../shared/widgets/my_loading.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../athlete_detail_controller.dart';

class MAthleteDetailBody extends StatelessWidget {
  const MAthleteDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteDetailController>();

    return Obx(() {
      if (controller.isLoadingProducts.value) return MyLoading();

      if (controller.resProducts.isEmpty) return SizedBox();

      return GridView.builder(
        padding: .fromLTRB(24, 32, 24, 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1 / 2,
        ),
        itemCount: controller.resProducts.length,
        itemBuilder: (context, index) {
          final items = controller.resProducts[index];

          return GestureDetector(
            onTap: () => controller.openDetail(items),
            child: Container(
              decoration: BoxDecoration(color: MyColors.black2),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  AspectRatio(aspectRatio: 1, child: MyImage(items.imageUrl)),
                  Padding(
                    padding: .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        MyText(
                          text: items.name,
                          fontSize: 16,
                          fontWeight: .w600,
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                        MyText(
                          text: "— ${items.color}",
                          fontWeight: .w600,
                          color: MyColors.white.withValues(alpha: 0.6),
                        ),
                        SizedBox(height: 8),
                        MyText(
                          text: parsingCurrency(items.price),
                          color: MyColors.white2.withValues(alpha: 0.8),
                        ),
                      ],
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
