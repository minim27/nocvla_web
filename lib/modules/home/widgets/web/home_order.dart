import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class HomeOrder extends StatelessWidget {
  const HomeOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      margin: .only(top: 96),
      padding: .symmetric(horizontal: 40, vertical: 48),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: MyColors.line)),
      ),
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                MyText(
                  text: "ORDER LANGSUNG, LEBIH HEMAT",
                  fontFamily: MyFonts.grenzeGotisch,
                  fontSize: 48,
                  fontWeight: .w600,
                ),
                MyText(
                  text: "Order lewat WhatsApp, ongkir dihitung admin.",
                  color: MyColors.white2,
                ),
              ],
            ),
          ),
          MyButton(
            "ORDER VIA WHATSAPP",
            width: 280,
            color: MyColors.red,
            textColor: MyColors.nativeWhite,
            onTap: controller.orderViaWhatsapp,
          ),
        ],
      ),
    );
  }
}
