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

class CollectionBody extends StatelessWidget {
  const CollectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Padding(
      padding: .fromLTRB(40, 32, 40, 56),
      child: Obx(() {
        if (controller.isLoadingProd.value) {
          return MyGrid(
            crossAxisCount: 4,
            children: [
              for (var i = 0; i < 4; i++)
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
          spacing: 56,
          children: [
            for (final items in groups)
              Column(
                crossAxisAlignment: .start,
                spacing: 16,
                children: [
                  header(controller, items),
                  MyGrid(
                    crossAxisCount: 4,
                    children: [
                      for (final item in items)
                        MyProductCard(
                          item: item,
                          colorFontSize: 24,
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

    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              MyText(
                text: items.first.name,
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 30,
                fontWeight: .w600,
              ),
              MyText(
                text:
                    "${items.length} warna · Mulai ${parsingCurrency(minPrice)}",
                color: MyColors.white2,
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: .opaque,
          onTap: () => controller.openDetail(items.first.id),
          child: SizedBox(
            height: 44,
            child: Center(
              child: MyText(
                text: "LIHAT DETAIL",
                fontFamily: MyFonts.archivoNarrow,
                fontSize: 13,
                fontWeight: .w600,
                letterSpacing: 13 * 0.12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
