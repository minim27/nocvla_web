import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/main_layout/main_layout_controller.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../home_controller.dart';

class THomeOrder extends StatelessWidget {
  const THomeOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final layout = Get.find<MainLayoutController>();

    return Padding(
      padding: .fromLTRB(40, 80, 40, 80),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.black4,
          border: .all(color: MyColors.line3),
        ),
        padding: .all(40),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 24,
          children: [
            Row(
              spacing: 24,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      MyText(
                        text: "Order langsung, lebih hemat.",
                        fontFamily: MyFonts.grenzeGotisch,
                        fontSize: 40,
                        fontWeight: .w600,
                      ),
                      MyText(
                        text:
                            "Pesan via WhatsApp untuk harga terbaik, atau checkout di marketplace favoritmu. Pakai kode atlet saat order WhatsApp.",
                        height: 1.5,
                        color: MyColors.white2,
                      ),
                    ],
                  ),
                ),
                MyButton(
                  "ORDER VIA WHATSAPP",
                  width: 260,
                  color: MyColors.red,
                  textColor: MyColors.nativeWhite,
                  prefixIcon: Icons.chat_bubble_outline,
                  onTap: controller.orderViaWhatsapp,
                ),
              ],
            ),
            Obx(
              () => layout.resMarketplace.isEmpty
                  ? SizedBox()
                  : MyGrid(
                      crossAxisCount: 3,
                      spacing: 8,
                      children: [
                        marketplace(layout, "BELI DI SHOPEE", "shopee_url"),
                        marketplace(
                          layout,
                          "BELI DI TIKTOK SHOP",
                          "tiktok_url",
                        ),
                        marketplace(
                          layout,
                          "BELI DI TOKOPEDIA",
                          "tokopedia_url",
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget marketplace(MainLayoutController layout, String label, String key) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => layout.openMarketplace(key),
      child: Container(
        height: 48,
        padding: .symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: MyColors.black3,
          border: .all(color: MyColors.line3),
        ),
        child: Row(
          children: [
            Expanded(
              child: MyText(
                text: label,
                fontFamily: MyFonts.archivoNarrow,
                fontSize: 12,
                fontWeight: .w700,
                letterSpacing: 12 * 0.12,
              ),
            ),
            Icon(Icons.north_east, color: MyColors.white2, size: 14),
          ],
        ),
      ),
    );
  }
}
