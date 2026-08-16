import 'package:flutter/material.dart';

import '../../data/models/athlete/athlete_model.dart';
import '../utils/my_colors.dart';
import 'my_image.dart';
import 'my_text.dart';

class MyAthleteCard extends StatelessWidget {
  const MyAthleteCard({super.key, required this.item, required this.onTap});

  final AthleteModel item;
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
            AspectRatio(
              aspectRatio: 1,
              child: MyImage(item.picture, fit: .cover),
            ),
            Padding(
              padding: .symmetric(horizontal: 12, vertical: 14),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  MyText(
                    text: item.name,
                    fontSize: 16,
                    fontWeight: .w600,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  MyText(
                    text: "CODE: ${item.code}",
                    maxLines: 1,
                    overflow: .ellipsis,
                    color: MyColors.white2.withValues(alpha: 0.6),
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
