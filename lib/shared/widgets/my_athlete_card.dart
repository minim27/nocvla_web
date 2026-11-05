import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/athlete/athlete_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_button.dart';
import 'my_divider.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyAthleteCard extends StatelessWidget {
  const MyAthleteCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onCopy,
    this.nameFontSize = 29.5,
  });

  static const double photoRatio = 1, contentHeight = 150;

  final AthleteModel item;
  final VoidCallback onTap;
  final VoidCallback onCopy;
  final double nameFontSize;

  @override
  Widget build(BuildContext context) {
    final products = ((item.products as List?) ?? [])
        .map(
          (e) => "${e["name"]}".replaceAll(
            RegExp(r" (Long Sleeve|Short Sleeve|Oversized T Shirt)$"),
            "",
          ),
        )
        .toSet()
        .join(", ");

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.black4,
          border: .all(color: MyColors.line3),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            AspectRatio(
              aspectRatio: photoRatio,
              child: MyImage(item.picture, alignment: .topCenter),
            ),
            SizedBox(
              height: contentHeight,
              child: Padding(
                padding: .fromLTRB(20, 20, 20, 15),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MyText(
                      text: "${item.name}".capitalize!,
                      fontFamily: MyFonts.grenzeGotisch,
                      fontSize: nameFontSize,
                      fontWeight: .w600,
                      height: 1.1,
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    SizedBox(height: 7),
                    MyText(
                      text: products.isEmpty ? "" : "Memakai $products",
                      fontSize: 12.8,
                      color: MyColors.white2,
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    MyDivider(color: MyColors.line2, topGap: 7, bottomGap: 13),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MyText(
                            text: "${item.code}",
                            fontFamily: MyFonts.archivoNarrow,
                            fontSize: 14,
                            fontWeight: .w700,
                            letterSpacing: 14 * 0.165,
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),
                        MyButtonBorder(
                          "SALIN KODE",
                          width: 103,
                          height: 35,
                          fontSize: 12,
                          fontWeight: .w700,
                          borderColor: MyColors.swatchBorder,
                          onTap: onCopy,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
