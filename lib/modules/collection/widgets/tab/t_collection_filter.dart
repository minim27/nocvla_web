import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_chip.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../collection_controller.dart';

class TCollectionFilter extends StatelessWidget {
  const TCollectionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Container(
      padding: .symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: MyColors.black3,
        border: Border.symmetric(horizontal: BorderSide(color: MyColors.line2)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            chips(
              children: [
                for (final items in controller.types)
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
                      text: "Ukuran ready",
                      fontSize: 13,
                      color: MyColors.white2,
                    ),
                  ),
                  for (final size in controller.sizes)
                    MyChip(
                      text: size,
                      width: 48,

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
