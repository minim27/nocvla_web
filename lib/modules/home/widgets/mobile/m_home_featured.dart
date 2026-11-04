import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/home/home_controller.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
import 'package:nocvla_web/shared/widgets/my_product_card.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class MHomeFeatured extends StatelessWidget {
  const MHomeFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoadingFeatured.value) return MyLoading();

      if (controller.resFeatured.isEmpty) return SizedBox();

      return Padding(
        padding: .fromLTRB(24, 90, 24, 140),
        child: Column(
          spacing: 40,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: MyText(
                    text: "FEATURED PRODUCTS",
                    fontSize: 32,
                    fontWeight: .w700,
                  ),
                ),
                // Opacity(
                //   opacity: 0.6,
                //   child: MyText(
                //     text: "VIEW ALL",
                //     fontSize: 16,
                //     color: MyColors.white2,
                //   ),
                // ),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                const crossAxisCount = 2;
                const crossAxisSpacing = 8.0;
                const textAreaHeight = 100.0;
                final columnWidth =
                    (constraints.maxWidth -
                        crossAxisSpacing * (crossAxisCount - 1)) /
                    crossAxisCount;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisExtent: columnWidth + textAreaHeight,
                  ),
                  itemCount: controller.resFeatured.length,
                  itemBuilder: (context, index) {
                    final items = controller.resFeatured[index];

                    return MyProductCard(
                      item: items,
                      onTap: () => controller.openDetail(items.id),
                     
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
