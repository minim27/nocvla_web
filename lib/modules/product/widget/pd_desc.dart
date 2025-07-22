import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../shared/utils/my_fonts.dart';
import '../../../shared/widgets/my_text.dart';
import '../product_detail_controller.dart';

class PDDesc extends GetView<ProductDetailController> {
  const PDDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "Description",
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 8),
        Column(
          spacing: 4,
          children: [
            ...List.generate(
              controller.res[0].description.length,
              (index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: "• "),
                  Expanded(
                    child: MyText(text: controller.res[0].description[index]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
