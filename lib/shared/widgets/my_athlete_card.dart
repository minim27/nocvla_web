import 'package:flutter/material.dart';

import '../../data/models/athlete/athlete_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyAthleteCard extends StatelessWidget {
  const MyAthleteCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onCopy,
  });

  final AthleteModel item;
  final VoidCallback onTap;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final products = ((item.products as List?) ?? [])
        .map((e) => e["name"])
        .join(", ");

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
            AspectRatio(aspectRatio: 1, child: MyImage(item.picture)),
            Padding(
              padding: .all(12),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4,
                children: [
                  MyText(
                    text: "${item.name}",
                    fontFamily: MyFonts.grenzeGotisch,
                    fontSize: 24,
                    fontWeight: .w600,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  if (products.isNotEmpty)
                    MyText(
                      text: products,
                      fontSize: 12,
                      color: MyColors.white2,
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                  MyText(text: "Kode: ${item.code}", fontWeight: .w600),
                  if (onCopy != null)
                    GestureDetector(
                      behavior: .opaque,
                      onTap: onCopy,
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(Icons.copy, color: MyColors.white2, size: 16),
                            MyText(text: "Salin kode", color: MyColors.white2),
                          ],
                        ),
                      ),
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
