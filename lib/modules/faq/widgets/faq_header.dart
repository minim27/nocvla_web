import 'package:flutter/material.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../shared/utils/my_dummies.dart';
import '../../../shared/utils/my_linears.dart';
import '../../../shared/widgets/my_image.dart';

class FAQHeader extends StatelessWidget {
  const FAQHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: .only(left: 250),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 2600 / 1070,
                child: MyImageAssets(
                  MyDummies.dumMovement,
                  alignment: .topCenter,
                  scale: 1,
                  fit: .cover,
                ),
              ),
              AspectRatio(
                aspectRatio: 2600 / 1070,
                child: Container(
                  decoration: BoxDecoration(gradient: MyLinears.linear1),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 40,
          top: 0,
          bottom: 0,
          child: Column(
            spacing: 16,
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: [
              MyText(
                text: "FREQUENTLY ASKED\nQUESTIONS",
                fontSize: 42,
                letterSpacing: 2,
                fontFamily: MyFonts.grenzeGotisch,
                height: 0.9,
              ),
              MyText(
                text:
                    "Temukan jawaban untuk pertanyaan\nyang sering ditanyakan.",
                fontSize: 16,
                color: MyColors.white2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
