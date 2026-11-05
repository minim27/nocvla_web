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
import '../../../../shared/widgets/my_grid.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_max_width.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../main_layout_controller.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainLayoutController>();

    return Column(
      children: [
        MyDivider(color: MyColors.line2),
        band(controller),
        MyDivider(color: MyColors.line2),
        Container(
          width: .infinity,
          color: MyColors.black6,
          padding: .fromLTRB(0, 72, 0, 40),
          child: MyMaxWidth(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                MyGrid(
                  crossAxisCount: 4,
                  spacing: 40,
                  children: [
                    brand(),
                    shopMenu(controller),
                    companyMenu(controller),
                    followMenu(controller),
                  ],
                ),
                SizedBox(height: 32),
                MyDivider(color: MyColors.line2, bottomGap: 20),
                bottom(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget band(MainLayoutController controller) {
    return Obx(() {
      if (controller.linkDiscord.value.isEmpty) return SizedBox();

      final text = Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "JOIN NOCVLA",
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 12,
            fontWeight: .w700,
            letterSpacing: 12 * 0.3,
            color: MyColors.redText,
          ),
          SizedBox(height: 11),
          MyText(
            text: "Be the first to know.",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 47.5,
            fontWeight: .w600,
            height: 1.0,
          ),
          SizedBox(height: 13),
          MyText(
            text:
                "Info drop, kata sandi early access, dan restock dibagikan duluan di Discord NOCVLA.",
            fontSize: 14.4,
            color: MyColors.white2,
          ),
        ],
      );
      final button = MyButton(
        "GABUNG DISCORD",
        width: 240,
        prefixIcon: Icons.discord,
        onTap: controller.openDiscordLink,
      );

      return Container(
        width: .infinity,
        color: MyColors.black4,
        padding: .symmetric(vertical: 56),
        child: MyMaxWidth(
          child: Row(
            spacing: 24,
            children: [
              Expanded(child: text),
              button,
            ],
          ),
        ),
      );
    });
  }

  Widget brand() {
    return Column(
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Container(
          width: 123,
          height: 44,
          padding: .only(left: 3),
          child: MyImageAssets(
            MyImages.imgNocvla,
            fit: .contain,
            alignment: .centerLeft,
          ),
        ),
        MyText(
          text:
              "Gothic training apparel. Dibuat untuk disiplin, fokus, dan progres.",
          height: 1.5,
          color: MyColors.white2,
        ),
      ],
    );
  }

  Widget bottom() {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: MyText(
            text: "© 2026 NOCVLA TEMPLE",
            fontSize: 12,
            color: MyColors.white2,
          ),
        ),
        MyText(
          text: "Built Different. Train Nocvla.",
          fontFamily: MyFonts.grenzeGotisch,
          fontSize: 16,
          fontWeight: .w600,
          color: MyColors.white2,
        ),
      ],
    );
  }

  Widget shopMenu(MainLayoutController controller) {
    return Obx(
      () => footerMenu(
        title: "BELANJA",
        items: {
          for (final e in controller.resType)
            if (controller.resShopType.contains(e.name))
              "${e.name}".capitalize!: () => controller.openCollection(e.name),
        },
      ),
    );
  }

  Widget companyMenu(MainLayoutController controller) {
    return footerMenu(
      title: "NOCVLA",
      items: {
        "Tentang kami": () => Get.toNamed(MyRoutes.about),
        "Atlet": () => Get.toNamed(MyRoutes.athlete),
        "Kontak & cara order": () => Get.toNamed(MyRoutes.contact),
        "nocvla.apparel@gmail.com": controller.openEmail,
      },
    );
  }

  Widget followMenu(MainLayoutController controller) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        footerMenu(
          title: "IKUTI",
          items: {
            "Instagram @${MyConfig.instagramUsername}": () =>
                execUri("https://instagram.com/${MyConfig.instagramUsername}"),
            "TikTok @${MyConfig.tiktokUsername}": () =>
                execUri("https://www.tiktok.com/@${MyConfig.tiktokUsername}"),
            "Discord NOCVLA": controller.openDiscordLink,
          },
        ),
        Obx(() {
          if (controller.resMarketplace.isEmpty) return SizedBox();

          return Column(
            crossAxisAlignment: .start,
            spacing: 4,
            children: [
              menuTitle("MARKETPLACE"),
              Wrap(
                crossAxisAlignment: .center,
                children: [
                  marketplace(controller, "Shopee", "shopee_url"),
                  MyText(text: " · ", color: MyColors.white2),
                  marketplace(controller, "TikTok Shop", "tiktok_url"),
                  MyText(text: " · ", color: MyColors.white2),
                  marketplace(controller, "Tokopedia", "tokopedia_url"),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget marketplace(
    MainLayoutController controller,
    String label,
    String key,
  ) {
    return GestureDetector(
      behavior: .opaque,
      onTap: () => controller.openMarketplace(key),
      child: SizedBox(
        height: 27,
        child: Center(
          widthFactor: 1,
          child: MyText(text: label, color: MyColors.white2),
        ),
      ),
    );
  }

  Widget menuTitle(String title) {
    return MyText(
      text: title,
      fontFamily: MyFonts.archivoNarrow,
      fontSize: 12,
      fontWeight: .w700,
      letterSpacing: 12 * 0.2,
    );
  }

  Widget footerMenu({
    required String title,
    required Map<String, VoidCallback> items,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        menuTitle(title),
        SizedBox(height: 8),
        ...items.entries.map(
          (e) => GestureDetector(
            behavior: .opaque,
            onTap: e.value,
            child: Container(
              constraints: BoxConstraints(minHeight: 27),
              alignment: .centerLeft,
              child: MyText(text: e.key, color: MyColors.white2),
            ),
          ),
        ),
      ],
    );
  }
}
