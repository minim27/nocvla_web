import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../app/services/my_config.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_images.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_divider.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../main_layout_controller.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainLayoutController>();

    return Column(
      children: [
        MyDivider(),
        Obx(() {
          if (controller.linkDiscord.value.isEmpty) return SizedBox();

          return Container(
            color: MyColors.black2,
            padding: .symmetric(horizontal: 60, vertical: 40),
            child: Row(
              spacing: 24,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 4,
                    children: [
                      MyText(
                        text: "JOIN NOCVLA",
                        fontSize: 32,
                        fontWeight: .w600,
                        fontFamily: MyFonts.grenzeGotisch,
                      ),
                      MyText(
                        text: "Be the first to know",
                        color: MyColors.white2,
                      ),
                    ],
                  ),
                ),
                MyButton(
                  "GABUNG DISCORD",
                  width: 220,
                  onTap: controller.openDiscordLink,
                ),
              ],
            ),
          );
        }),
        MyDivider(),
        Padding(
          padding: .fromLTRB(60, 56, 60, 24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(flex: 2, child: brand()),
                  Expanded(child: shopMenu(controller)),
                  Expanded(child: companyMenu()),
                  Expanded(child: followMenu()),
                ],
              ),
              SizedBox(height: 40),
              MyDivider(bottomGap: 20),
              MyText(
                text: "© 2026 NOCVLA. All Rights Reserved.",
                fontSize: 12,
                color: MyColors.white2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget brand() {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        SizedBox(
          width: 165,
          height: 56,
          child: MyImageAssets(
            MyImages.imgNocvla,
            fit: .contain,
            alignment: .centerLeft,
          ),
        ),
        MyText(text: "Built Different. Train NOCVLA.", color: MyColors.white2),
      ],
    );
  }

  Widget shopMenu(MainLayoutController controller) {
    return Obx(
      () => footerMenu(
        title: "BELANJA",
        items: {
          for (final e in controller.resType)
            "${e.name}".toLowerCase().capitalizeFirst!: () =>
                controller.openCollection(e.name),
        },
      ),
    );
  }

  Widget companyMenu() {
    return footerMenu(
      title: "NOCVLA",
      items: {
        "Tentang": () => Get.toNamed(MyRoutes.about),
        "Atlet": () => Get.toNamed(MyRoutes.athlete),
        "Kontak": () => Get.toNamed(MyRoutes.contact),
      },
    );
  }

  Widget followMenu() {
    return footerMenu(
      title: "IKUTI",
      items: {
        "Instagram": () =>
            execUri("https://instagram.com/${MyConfig.instagramUsername}"),
        "TikTok": () =>
            execUri("https://www.tiktok.com/@${MyConfig.tiktokUsername}"),
      },
    );
  }

  Widget footerMenu({
    required String title,
    required Map<String, VoidCallback> items,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        MyText(
          text: title,
          fontFamily: MyFonts.archivoNarrow,
          fontWeight: .w700,
          letterSpacing: 14 * 0.12,
        ),
        SizedBox(height: 8),
        ...items.entries.map(
          (e) => GestureDetector(
            behavior: .opaque,
            onTap: e.value,
            child: Container(
              height: 44,
              alignment: .centerLeft,
              child: MyText(text: e.key, color: MyColors.white2),
            ),
          ),
        ),
      ],
    );
  }
}
