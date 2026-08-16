import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/my_loading.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../collection_controller.dart';

class MCollectionBody extends StatelessWidget {
  const MCollectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Obx(() {
      if (controller.isLoadingProd.value) return MyLoading();

      if (controller.resProducts.isEmpty) return SizedBox();

      return LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisCount = 2;
          const crossAxisSpacing = 8.0;
          const horizontalPadding = 24.0;
          const textAreaHeight = 100.0;
          final columnWidth =
              (constraints.maxWidth -
                  horizontalPadding * 2 -
                  crossAxisSpacing * (crossAxisCount - 1)) /
              crossAxisCount;

          return GridView.builder(
            padding: .fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisExtent: columnWidth + textAreaHeight,
            ),
            itemCount: controller.resProducts.length,
            itemBuilder: (context, index) {
              final items = controller.resProducts[index];

              return MyProductCard(
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
