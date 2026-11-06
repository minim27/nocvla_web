import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class MAboutTarget extends StatelessWidget {
  const MAboutTarget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();

    return Obx(() {
      final items = [
        for (final (label, key) in controller.targets)
          if (controller.resAbout[key] != null)
            (label, controller.resAbout[key]!),
      ];
      if (items.isEmpty) return SizedBox();

      return Padding(
        padding: .fromLTRB(24, 64, 24, 0),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.black4,
            border: .all(color: MyColors.line2),
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              for (final (i, item) in items.indexed)
                Container(
                  decoration: BoxDecoration(
                    border: i == 0
                        ? null
                        : Border(top: BorderSide(color: MyColors.line2)),
                  ),
                  child: cell(item.$1, item.$2),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget cell(String label, String value) {
    return Container(
      padding: .all(24),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: label,
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 11,
            fontWeight: .w700,
            letterSpacing: 11 * 0.2,
            color: MyColors.redText,
          ),
          SizedBox(height: 18),
          MyText(
            text: value,
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 24,
            fontWeight: .w600,
            height: 1.15,
          ),
        ],
      ),
    );
  }
}
