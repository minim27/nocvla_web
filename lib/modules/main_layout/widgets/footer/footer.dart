import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/my_routes.dart';
import '../../../../app/services/my_config.dart';
import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_icons.dart';
import '../../../../shared/utils/my_utility.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .fromLTRB(60, 60, 60, 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: MyColors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MyText(
                      text: "NOCVLA",
                      fontSize: 32,
                      fontFamily: MyFonts.bebasNeue,
                    ),
                    SizedBox(height: 12),
                    MyText(
                      text:
                          "Performance gear designed for discipline, focus, and progress.",
                      color: MyColors.white.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: footerMenu(
                  title: "SHOP",
                  items: {
                    "Compression": () => Get.toNamed(MyRoutes.collection),
                    "Oversized": () => Get.toNamed(MyRoutes.collection),
                    "Accessories": () => Get.toNamed(MyRoutes.collection),
                  },
                ),
              ),
              Expanded(
                child: footerMenu(
                  title: "COMPANY",
                  items: {
                    "About": () => Get.toNamed(MyRoutes.about),
                    "Athlete": () => Get.toNamed(MyRoutes.athlete),
                    // "FAQ": () => Get.toNamed(MyRoutes.faq),
                    "Contact": () => Get.toNamed(MyRoutes.contact),
                  },
                ),
              ),
              // Expanded(
              //   child: footerMenu(
              //     title: "SUPPORT",
              //     items: {
              //       "Shipping": () {},
              //       "Returns": () {},
              //       "Size Guide": () {},
              //       "Privacy Policy": () {},
              //     },
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MyText(text: "FOLLOW US", fontWeight: .w600),
                    SizedBox(height: 20),
                    Row(
                      spacing: 12,
                      children: [
                        GestureDetector(
                          onTap: () => execUri(
                            "https://instagram.com/${MyConfig.instagramUsername}",
                          ),
                          child: MyImageAssets(MyIcons.icInstagram),
                        ),
                        GestureDetector(
                          onTap: () => execUri(
                            "https://www.tiktok.com/@${MyConfig.tiktokUsername}",
                          ),
                          child: MyImageAssets(MyIcons.icTikTok),
                        ),
                        // MyImageAssets(MyIcons.icWhatsapp),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 48),
          Divider(color: MyColors.white.withValues(alpha: 0.08)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: MyText(
                  text: "© 2026 NOCVLA. All Rights Reserved.",
                  color: MyColors.white.withValues(alpha: 0.5),
                ),
              ),
              MyText(
                text: "Built Different. Train NOCVLA.",
                color: MyColors.white.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget footerMenu({
    required String title,
    required Map<String, VoidCallback> items,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        MyText(text: title, fontWeight: .w600),
        SizedBox(height: 20),
        ...items.entries.map(
          (e) => Padding(
            padding: .only(bottom: 12),
            child: GestureDetector(
              onTap: e.value,
              child: MyText(
                text: e.key,
                color: MyColors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
