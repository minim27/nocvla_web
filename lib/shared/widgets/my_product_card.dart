import 'package:flutter/material.dart';

import '../../data/models/collections/list_products_model.dart';
import '../utils/my_colors.dart';
import '../utils/my_parsing_currency.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard({super.key, required this.item, required this.onTap});

  final ListProductsModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: MyColors.black2),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            AspectRatio(aspectRatio: 1, child: MyImage(item.imageUrl)),
            Padding(
              padding: .symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(text: item.name, maxLines: 1, overflow: .ellipsis),
                  MyText(
                    text: "— ${item.color}",
                    fontSize: 12,
                    maxLines: 1,
                    overflow: .ellipsis,
                    color: MyColors.white.withValues(alpha: 0.6),
                  ),
                  SizedBox(height: 8),
                  MyText(
                    text: parsingCurrency(item.price),
                    fontWeight: .w600,
                    maxLines: 1,
                    overflow: .ellipsis,
                    color: MyColors.white2.withValues(alpha: 0.8),
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
