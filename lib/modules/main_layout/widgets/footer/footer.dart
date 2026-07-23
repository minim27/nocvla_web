import 'package:flutter/material.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_icons.dart';
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
                  items: ["Compression", "Oversized", "Accessories"],
                ),
              ),
              Expanded(
                child: footerMenu(
                  title: "COMPANY",
                  items: ["About", "Athlete", "FAQ", "Contact"],
                ),
              ),
              Expanded(
                child: footerMenu(
                  title: "SUPPORT",
                  items: [
                    "Shipping",
                    "Returns",
                    "Size Guide",
                    "Privacy Policy",
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MyText(text: "FOLLOW US", fontWeight: .w600),
                    SizedBox(height: 20),
                    Row(
                      spacing: 12,
                      children: [
                        MyImageAssets(MyIcons.icInstagram),
                        MyImageAssets(MyIcons.icTikTok),
                        MyImageAssets(MyIcons.icWhatsapp),
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

  Widget footerMenu({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        MyText(text: title, fontWeight: .w600),
        SizedBox(height: 20),
        ...items.map(
          (e) => Padding(
            padding: .only(bottom: 12),
            child: MyText(
              text: e,
              color: MyColors.white.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
