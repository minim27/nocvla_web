import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_chip.dart';
import '../../../../shared/widgets/my_max_width.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../collection_controller.dart';

class CollectionFilter extends StatelessWidget {
  const CollectionFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Container(
      decoration: BoxDecoration(
        color: MyColors.black3,
        border: Border.symmetric(horizontal: BorderSide(color: MyColors.line2)),
      ),
      child: MyMaxWidth(
        child: Padding(
          padding: .symmetric(vertical: 14),
          child: Obx(
            () => Row(
              spacing: 8,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: .horizontal,
                    child: Row(
                      spacing: 8,
                      children: [
                        for (final items in controller.types)
                          MyChip(
                            text: items.name,
                            height: 40,
                            isSelected:
                                controller.selectedType.value ==
                                (items.value.isEmpty
                                    ? items.value
                                    : items.name),
                            onTap: () => controller.selectType(
                              items.value.isEmpty ? items.value : items.name,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (controller.sizes.isNotEmpty) ...[
                  Padding(
                    padding: .only(right: 4),
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
                      height: 40,
                      isSelected: controller.selectedSize.value == size,
                      onTap: () => controller.selectSize(size),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
