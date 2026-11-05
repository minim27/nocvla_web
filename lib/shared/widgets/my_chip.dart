import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_text.dart';

class MyChip extends StatelessWidget {
  const MyChip({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
    this.width,
    this.height = 44,
  });

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: width == null ? const .symmetric(horizontal: 16) : null,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.white : null,
          border: .all(color: isSelected ? MyColors.white : MyColors.line2),
        ),
        child: Center(
          widthFactor: 1,
          child: MyText(
            text: text.toUpperCase(),
            color: isSelected ? MyColors.black : MyColors.white,
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 13,
            fontWeight: .w700,
            letterSpacing: 13 * 0.12,
          ),
        ),
      ),
    );
  }
}
