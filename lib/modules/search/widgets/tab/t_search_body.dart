import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_chip.dart';
import '../../../../shared/widgets/my_empty_state.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_loading.dart';
import '../../../../shared/widgets/my_product_card.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import '../../search_controller.dart';

class TSearchBody extends StatelessWidget {
  const TSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchPageController>();

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: MyColors.line2)),
          ),
          child: Padding(
            padding: .symmetric(horizontal: 40, vertical: 13),
            child: Row(
              spacing: 18,
              children: [
                Icon(Icons.search, color: MyColors.white2, size: 22),
                Expanded(
                  child: MyTextFormFieldNoBorder(
                    controller: controller.txtQuery,
                    hintText: "Cari produk...",
                    hintTextColor: MyColors.white2,
                    textAlign: .start,
                    autofocus: true,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 30,
                    fontWeight: .w600,
                    onChanged: controller.onChanged,
                  ),
                ),
                Obx(
                  () => controller.query.value.isEmpty
                      ? SizedBox()
                      : GestureDetector(
                          behavior: .opaque,
                          onTap: controller.clearQuery,
                          child: Container(
                            height: 40,
                            padding: .symmetric(horizontal: 13),
                            alignment: .center,
                            decoration: BoxDecoration(
                              border: .all(color: MyColors.line2),
                            ),
                            child: MyText(
                              text: "Hapus",
                              fontSize: 12.5,
                              color: MyColors.white2,
                            ),
                          ),
                        ),
                ),
                GestureDetector(
                  behavior: .opaque,
                  onTap: controller.close,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      border: .all(color: MyColors.line2),
                    ),
                    child: Icon(Icons.close, color: MyColors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: .fromLTRB(40, 28, 40, 64),
          child: Obx(
            () => Column(
              crossAxisAlignment: .stretch,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: .center,
                  children: [
                    Padding(
                      padding: .only(right: 6),
                      child: MyText(
                        text: "Populer",
                        fontSize: 13,
                        color: MyColors.white2,
                      ),
                    ),
                    for (final item in controller.popular)
                      MyChip(
                        text: item,
                        height: 36,
                        onTap: () => controller.selectPopular(item),
                      ),
                  ],
                ),
                SizedBox(height: 31),
                if (controller.isLoading.value)
                  MyMoreLoading()
                else if (controller.query.value.trim().isNotEmpty) ...[
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: MyText(
                          text:
                              "${controller.results.length} COLORWAY DITEMUKAN",
                          fontFamily: MyFonts.archivoNarrow,
                          fontSize: 13,
                          fontWeight: .w700,
                          letterSpacing: 13 * 0.15,
                        ),
                      ),
                      GestureDetector(
                        behavior: .opaque,
                        onTap: controller.openCollection,
                        child: MyText(
                          text: "Lihat semua di koleksi",
                          fontSize: 12.5,
                          color: MyColors.white2,
                          decoration: .underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(height: 1, color: MyColors.line2),
                  SizedBox(height: 29),
                  if (controller.results.isEmpty)
                    MyEmptyState(text: "Tidak ada hasil untuk pencarian ini.")
                  else
                    MyGrid(
                      crossAxisCount: 3,
                      spacing: 17,
                      children: [
                        for (final items in controller.results)
                          MyProductCard(
                            item: items,
                            colorFontSize: 24,
                            showStatus: false,
                            onTap: () => controller.openDetail(items.id),
                          ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
