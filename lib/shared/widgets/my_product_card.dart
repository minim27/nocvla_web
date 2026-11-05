import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/collections/list_products_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import '../utils/my_parsing_currency.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard({
    super.key,
    required this.item,
    required this.onTap,
    this.colorFontSize = 28,
  });

  final ListProductsModel item;
  final VoidCallback onTap;
  final double colorFontSize;

  @override
  Widget build(BuildContext context) {
    final totalQty = item.totalQty;
    final isSoldOut = totalQty <= 0;
    final isLimited = !isSoldOut && totalQty <= 3;
    final statusColor = isSoldOut
        ? MyColors.white2
        : isLimited
        ? MyColors.orange
        : MyColors.green;

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
              aspectRatio: 1,
              child: Stack(
                fit: .expand,
                children: [
                  isSoldOut
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            MyColors.black,
                            BlendMode.saturation,
                          ),
                          child: MyImage(item.imageUrl),
                        )
                      : MyImage(item.imageUrl),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: .symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: MyColors.black3,
                        border: .all(color: MyColors.line2),
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        spacing: 6,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          MyText(
                            text: isSoldOut
                                ? "HABIS"
                                : isLimited
                                ? "STOK TERBATAS"
                                : "READY",
                            fontFamily: MyFonts.archivoNarrow,
                            fontSize: 11,
                            fontWeight: .w600,
                            letterSpacing: 11 * 0.14,
                            color: statusColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(
                    text: "${item.name}"
                        .replaceAll(RegExp(r" (T Shirt|Tee)$"), "")
                        .toUpperCase(),
                    fontFamily: MyFonts.archivoNarrow,
                    fontSize: 11,
                    fontWeight: .w600,
                    letterSpacing: 11 * 0.155,
                    maxLines: 1,
                    overflow: .ellipsis,
                    color: MyColors.white2,
                  ),
                  SizedBox(height: 4),
                  MyText(
                    text: "${item.color}".capitalize!,
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: colorFontSize,
                    fontWeight: .w600,
                    height: 1.1,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  SizedBox(height: 8),
                  MyText(
                    text: parsingCurrency(item.price),
                    fontSize: 13.6,
                    fontWeight: .w600,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFeaturedCard extends StatelessWidget {
  const MyFeaturedCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onColorTap,
  });

  final ListProductsModel item;
  final VoidCallback onTap;
  final ValueChanged<String> onColorTap;

  @override
  Widget build(BuildContext context) {
    final colors = (item.colors as List?) ?? [];

    return Column(
      crossAxisAlignment: .start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(
              fit: .expand,
              children: [
                MyImage(item.imageUrl),
                if (item.badge != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: .symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: MyColors.black,
                        border: .all(color: MyColors.line3),
                      ),
                      child: MyText(
                        text: "${item.badge}",
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 11,
                        fontWeight: .w700,
                        letterSpacing: 11 * 0.12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        MyText(
          text: "${item.name}",
          fontWeight: .w600,
          maxLines: 1,
          overflow: .ellipsis,
        ),
        SizedBox(height: 4),
        MyText(
          text: "${item.type} · ${colors.length} warna",
          fontSize: 13,
          color: MyColors.white2,
        ),
        SizedBox(height: 8),
        Row(
          spacing: 4,
          children: [
            Expanded(
              child: MyText(
                text: parsingCurrency(item.price),
                fontWeight: .w600,
                maxLines: 1,
                overflow: .ellipsis,
              ),
            ),
            for (final color in colors)
              GestureDetector(
                onTap: () => onColorTap(color["id"]),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color["swatch"],
                    shape: BoxShape.circle,
                    border: .all(color: MyColors.swatchBorder),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
