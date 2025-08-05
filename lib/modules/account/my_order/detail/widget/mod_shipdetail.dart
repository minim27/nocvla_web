import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../my_order_detail_controller.dart';

class MODShipDetail extends GetView<MyOrderDetailController> {
  const MODShipDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "Shipping Detail",
          fontSize: 24,
          fontFamily: MyFonts.libreBaskerville,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "Shipping",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
            MyText(
              text: "J&T",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
          ],
        ),
        Divider(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: "No Resi",
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
            MyText(
              text: controller.res[0].shipping["no_resi"],
              fontSize: 12,
              fontFamily: MyFonts.libreBaskerville,
            ),
          ],
        ),
      ],
    );
  }
}
