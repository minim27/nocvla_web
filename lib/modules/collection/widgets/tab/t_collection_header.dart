import 'package:flutter/material.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';

class TCollectionHeader extends StatelessWidget {
  const TCollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(40, 48, 40, 24),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "THE ARMORY",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 56,
            fontWeight: .w600,
          ),
          MyText(
            text: "Engineered for performance.",
            fontSize: 16,
            color: MyColors.white2,
          ),
        ],
      ),
    );
  }
}
