import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class MHomeOrder extends StatelessWidget {
  const MHomeOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      margin: .only(top: 64),
      padding: .symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: MyColors.line)),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              MyText(
                text: "ORDER LANGSUNG, LEBIH HEMAT",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 32,
                fontWeight: .w600,
              ),
              MyText(
                text: "Order lewat WhatsApp, ongkir dihitung admin.",
                color: MyColors.white2,
              ),
            ],
          ),
          MyButton(
            "ORDER VIA WHATSAPP",
            color: MyColors.red,
            textColor: MyColors.nativeWhite,
            onTap: controller.orderViaWhatsapp,
          ),
        ],
      ),
    );
  }
}
