import 'package:flutter/material.dart';

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
    this.colorFontSize = 24,
  });

  final ListProductsModel item;
  final VoidCallback onTap;
  final double colorFontSize;

  @override
  Widget build(BuildContext context) {
    final totalQty = item.totalQty;
    final isSoldOut = totalQty <= 0;
    final isLimited = !isSoldOut && totalQty <= 3;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.black2,
          border: .all(color: MyColors.line),
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
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: .symmetric(horizontal: 8, vertical: 4),
                      color: MyColors.black,
                      child: MyText(
                        text: isSoldOut
                            ? "HABIS"
                            : isLimited
                            ? "STOK TERBATAS"
                            : "READY",
                        fontFamily: MyFonts.archivoNarrow,
                        fontSize: 11,
                        fontWeight: .w600,
                        letterSpacing: 11 * 0.12,
                        color: isSoldOut
                            ? MyColors.white2
                            : isLimited
                            ? MyColors.orange
                            : MyColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: .all(12),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4,
                children: [
                  MyText(
                    text: "${item.name}",
                    fontSize: 12,
                    maxLines: 1,
                    overflow: .ellipsis,
                    color: MyColors.white2,
                  ),
                  MyText(
                    text: "${item.color}",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: colorFontSize,
                    fontWeight: .w600,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  MyText(
                    text: parsingCurrency(item.price),
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
