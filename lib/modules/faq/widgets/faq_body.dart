import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/faq/faq_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_utility.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

class FAQBody extends StatelessWidget {
  const FAQBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FAQController>();

    return Padding(
      padding: .fromLTRB(40, 20, 40, 0),
      child: Column(
        spacing: 12,
        children: .generate(controller.res.length, (index) {
          final items = controller.res[index];

          return Container(
            padding: .symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              border: .all(color: MyColors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    MyText(
                      text: "${index + 1}.  ",
                      fontSize: 16,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                    MyText(
                      text: items["question"],
                      fontSize: 16,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => changeStatusBool(items["show"]),
                  child: Obx(
                    () => Icon(
                      (items["show"].value) ? Icons.remove : Icons.add,
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
