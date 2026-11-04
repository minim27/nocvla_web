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
  });

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: .opaque,
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const .symmetric(horizontal: 16),
        alignment: .center,
        decoration: BoxDecoration(
          color: isSelected ? MyColors.white : null,
          border: .all(color: isSelected ? MyColors.white : MyColors.line),
        ),
        child: MyText(
          text: text.toUpperCase(),
          color: isSelected ? MyColors.black : MyColors.white,
          fontFamily: MyFonts.archivoNarrow,
          fontSize: 13,
          fontWeight: .w600,
          letterSpacing: 13 * 0.12,
        ),
      ),
    );
  }
}
