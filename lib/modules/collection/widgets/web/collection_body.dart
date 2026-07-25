import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_loading.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../collection_controller.dart';

class CollectionBody extends StatelessWidget {
  const CollectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Obx(() {
      if (controller.isLoadingProd.value) return MyLoading();

      if (controller.resProducts.isEmpty) return SizedBox();

      return GridView.builder(
        padding: .fromLTRB(40, 32, 40, 0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: controller.resProducts.length,
        itemBuilder: (context, index) {
          final items = controller.resProducts[index];

          return GestureDetector(
            onTap: () => controller.openDetail(items.id),
            child: Container(
              decoration: BoxDecoration(color: MyColors.black2),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  MyImage(items.imageUrl),
                  Padding(
                    padding: .all(24),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        MyText(
                          text: items.name,
                          fontSize: 20,
                          fontWeight: .w600,
                          maxLines: 2,
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
                          fontSize: 18,
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
