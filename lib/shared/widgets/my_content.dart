import 'package:flutter/material.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/utils/my_parsing_currency.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import 'my_image.dart';

class MyProduct extends StatelessWidget {
  const MyProduct({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.stock,
    required this.onTap,
  });

  final String image, text;
  final int price, stock;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 180 / 200,
                child: MyImage(image: image, alignment: Alignment.topCenter),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  color: MyColors.primary.withValues(alpha: 0.3),
                  width: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: stock > 0 ? MyColors.green : MyColors.yellow,
                          ),
                        ),
                      ),
                      Flexible(
                        child: MyText(
                          text: stock > 0
                              ? "IN STOCK - READY TO SHIP"
                              : "SOLD OUT - PRE ORDER",
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: text, fontSize: 12, fontWeight: FontWeight.w600),
                SizedBox(height: 8),
                MyText(
                  text: parsingCurrency(price),
                  fontFamily: MyFonts.libreBaskerville,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
