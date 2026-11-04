import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_chip.dart';
import '../../../../shared/widgets/my_divider.dart';
import '../../../../shared/widgets/my_empty_state.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_loading.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import '../../search_controller.dart';

class TSearchBody extends StatelessWidget {
  const TSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchPageController>();

    return Padding(
      padding: .symmetric(horizontal: 40, vertical: 36),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 24,
        children: [
          MyTextFormFieldNoBorder(
            controller: controller.txtQuery,
            hintText: "Cari produk...",
            hintTextColor: MyColors.white2,
            textAlign: .start,
            autofocus: true,
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 56,
            fontWeight: .w600,
            onChanged: controller.onChanged,
          ),
          MyDivider(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in controller.popular)
                MyChip(text: item, onTap: () => controller.selectPopular(item)),
            ],
          ),
          Obx(() {
            if (controller.isLoading.value) return MyMoreLoading();
            if (controller.query.value.trim().isEmpty) return SizedBox();

            final results = controller.results;
            if (results.isEmpty) {
              return MyEmptyState(text: "Tidak ada hasil untuk pencarian ini.");
            }

            return MyGrid(
              crossAxisCount: 3,
              children: [
                for (final items in results)
                  MyProductCard(
                    item: items,
                    colorFontSize: 22,
                    onTap: () => controller.openDetail(items.id),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
