import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_chip.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../collection_controller.dart';

class CollectionFilter extends StatelessWidget {
  const CollectionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Container(
      padding: .symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: MyColors.black3,
        border: Border(bottom: BorderSide(color: MyColors.line)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            chips(
              children: [
                for (final items in controller.resType)
                  MyChip(
                    text: items.name,
                    isSelected:
                        controller.selectedType.value ==
                        (items.value.isEmpty ? items.value : items.name),
                    onTap: () => controller.selectType(
                      items.value.isEmpty ? items.value : items.name,
                    ),
                  ),
              ],
            ),
            if (controller.sizes.isNotEmpty)
              chips(
                children: [
                  Center(
                    child: MyText(
                      text: "UKURAN READY",
                      fontFamily: MyFonts.archivoNarrow,
                      fontSize: 13,
                      fontWeight: .w600,
                      letterSpacing: 13 * 0.12,
                      color: MyColors.white2,
                    ),
                  ),
                  for (final size in controller.sizes)
                    MyChip(
                      text: size,
                      isSelected: controller.selectedSize.value == size,
                      onTap: () => controller.selectSize(size),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget chips({required List<Widget> children}) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      padding: .symmetric(horizontal: 40),
      child: SizedBox(height: 44, child: Row(spacing: 8, children: children)),
    );
  }
}
