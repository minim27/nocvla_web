import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/collection/collection_controller.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/widgets/my_loading.dart';

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "COLLECTION",
            fontSize: 42,
            letterSpacing: 2,
            fontFamily: MyFonts.grenzeGotisch,
          ),
          MyText(
            text: "Engineered for performance.",
            fontSize: 16,
            color: MyColors.white2,
          ),
          SizedBox(height: 42),
          Obx(() {
            if (controller.isLoadingType.value) return MyLoading();

            return Row(
              spacing: 12,
              children: .generate(controller.resType.length, (index) {
                final items = controller.resType[index];
                final filterValue = items.value.isEmpty
                    ? items.value
                    : items.name;

                return GestureDetector(
                  onTap: () => controller.selectType(filterValue),
                  child: Obx(
                    () => Container(
                      padding: .symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: controller.selectedType.value == filterValue
                            ? MyColors.white
                            : MyColors.white.withValues(alpha: 0),
                      ),
                      child: MyText(
                        text: items.name,
                        color: controller.selectedType.value == filterValue
                            ? MyColors.black
                            : MyColors.white.withValues(alpha: 0.6),
                        fontWeight: controller.selectedType.value == filterValue
                            ? .w500
                            : .w400,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
