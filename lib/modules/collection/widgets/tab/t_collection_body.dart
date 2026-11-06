import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_parsing_currency.dart';
import '../../../../shared/widgets/my_empty_state.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_skeleton.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../collection_controller.dart';

class TCollectionBody extends StatelessWidget {
  const TCollectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Padding(
      padding: .fromLTRB(40, 32, 40, 48),
      child: Obx(() {
        if (controller.isLoadingProd.value) {
          return MyGrid(
            crossAxisCount: 3,
            children: [
              for (var i = 0; i < 3; i++)
                AspectRatio(aspectRatio: 1, child: MySkeleton(height: null)),
            ],
          );
        }

        final groups = controller.groups;
        if (groups.isEmpty) {
          return MyEmptyState(text: "Belum ada produk untuk pilihan ini.");
        }

        return Column(
          crossAxisAlignment: .start,
          spacing: 48,
          children: [
            for (final items in groups)
              Column(
                crossAxisAlignment: .start,
                spacing: 20,
                children: [
                  header(controller, items),
                  MyGrid(
                    crossAxisCount: 3,
                    children: [
                      for (final item in items)
                        MyProductCard(
                          item: item,
                          colorFontSize: 26,
                          onTap: () => controller.openDetail(item.id),
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

  Widget header(CollectionController controller, List items) {
    final minPrice = items
        .map((e) => e.price as int)
        .reduce((a, b) => a < b ? a : b);
    final desc = controller.groupDesc(items.first);

    return Container(
      width: .infinity,
      padding: .only(bottom: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line2)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: controller.groupEyebrow(items.first),
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 12,
            fontWeight: .w600,
            letterSpacing: 12 * 0.22,
            color: MyColors.redText,
          ),
          SizedBox(height: 9),
          Row(
            crossAxisAlignment: .end,
            spacing: 20,
            children: [
              Expanded(
                child: MyText(
                  text: items.first.name,
                  fontFamily: MyFonts.grenzeGotisch,
                  fontSize: 34,
                  fontWeight: .w600,
                  height: 1.0,
                ),
              ),
              if (desc == null) ...[
                info(items.length, minPrice),
                detail(controller, items),
              ],
            ],
          ),
          if (desc != null) ...[
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: .baseline,
              textBaseline: .alphabetic,
              spacing: 20,
              children: [
                Expanded(
                  child: MyText(
                    text: desc,
                    fontSize: 14,
                    color: MyColors.white2,
                  ),
                ),
                info(items.length, minPrice),
                detail(controller, items),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget info(int count, int minPrice) {
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .baseline,
      textBaseline: .alphabetic,
      children: [
        MyText(
          text: "$count warna · mulai ",
          fontSize: 13.5,
          color: MyColors.white2,
        ),
        MyText(
          text: parsingCurrency(minPrice),
          fontSize: 13.5,
          fontWeight: .w600,
        ),
      ],
    );
  }

  Widget detail(CollectionController controller, List items) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => controller.openDetail(items.first.id),
      child: Container(
        padding: .only(bottom: 7),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: MyColors.swatchBorder)),
        ),
        child: MyText(
          text: "DETAIL SERI",
          fontFamily: MyFonts.archivoNarrow,
          fontSize: 12,
          fontWeight: .w700,
          letterSpacing: 12 * 0.19,
        ),
      ),
    );
  }
}
