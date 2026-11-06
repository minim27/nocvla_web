import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../about_controller.dart';

class AboutTarget extends StatelessWidget {
  const AboutTarget({super.key});

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

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
          child: Padding(
            padding: .fromLTRB(48, 112, 48, 0),
            child: SizedBox(
              width: .infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.black4,
                  border: .all(color: MyColors.line2),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: .stretch,
                    children: [
                      for (final (i, item) in items.indexed)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: i == 0
                                  ? null
                                  : Border(
                                      left: BorderSide(color: MyColors.line2),
                                    ),
                            ),
                            child: cell(item.$1, item.$2),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget cell(String label, String value) {
    return Container(
      padding: .fromLTRB(32, 34, 32, 36),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: label,
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 12,
            fontWeight: .w700,
            letterSpacing: 12 * 0.2,
            color: MyColors.redText,
          ),
          SizedBox(height: 13),
          MyText(
            text: value,
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 30.7,
            fontWeight: .w600,
            height: 1.075,
          ),
        ],
      ),
    );
  }
}
