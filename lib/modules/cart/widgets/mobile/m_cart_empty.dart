import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_dash_border.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../cart_controller.dart';

class MCartEmpty extends StatelessWidget {
  const MCartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return MyDashBorder(
      child: Padding(
        padding: .symmetric(vertical: 56, horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              MyText(
                text: "Keranjang masih kosong",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 30,
                fontWeight: .w700,
                height: 1.1,
                textAlign: .center,
              ),
              SizedBox(height: 20),
              MyText(
                text: "Pilih colorway favoritmu dari koleksi.",
                fontSize: 14.4,
                color: MyColors.white2,
                textAlign: .center,
              ),
              SizedBox(height: 16),
              MyButton(
                "LIHAT KOLEKSI",
                width: 177,
                height: 52,
                fontSize: 13,
                fontWeight: .w700,
                onTap: controller.continueShopping,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
