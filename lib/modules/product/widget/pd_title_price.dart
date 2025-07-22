import 'package:flutter/widgets.dart';

import '../../../shared/utils/my_colors.dart';
import '../../../shared/utils/my_fonts.dart';
import '../../../shared/utils/my_parsing_currency.dart';
import '../../../shared/widgets/my_text.dart';
import '../product_detail_controller.dart';

class PDTitlePrice extends StatelessWidget {
  const PDTitlePrice({super.key, required this.controller});

  final ProductDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: controller.res[0].name,
          fontSize: 18,
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: [
                MyText(
                  text: parsingCurrency(controller.res[0].price["regular"]),
                  color: MyColors.primary60,
                  decoration: TextDecoration.lineThrough,
                ),
                SizedBox(width: 8),
              ],
            ),
            MyText(
              text: parsingCurrency(controller.res[0].price["default"]),
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: MyColors.red,
            ),
          ],
        ),
      ],
    );
  }
}
