import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/home/home_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_parsing_currency.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_loading.dart';
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
                MyText(
                  text: "FEATURED PRODUCTS",
                  fontSize: 32,
                  fontWeight: .w700,
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
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1 / 1.8,
              ),
              itemCount: controller.resFeatured.length,
              itemBuilder: (context, index) {
                final items = controller.resFeatured[index];

                return GestureDetector(
                  onTap: () => controller.openDetail(items.id),
                  child: Container(
                    decoration: BoxDecoration(color: MyColors.black2),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: MyImage(items.imageUrl),
                        ),
                        Padding(
                          padding: .all(20),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              MyText(
                                text: items.name,
                                fontSize: 16,
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
            ),
          ],
        ),
      );
    });
  }
}
