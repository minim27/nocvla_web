import 'package:flutter/material.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';

class MCollectionHeader extends StatelessWidget {
  const MCollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(24, 40, 24, 24),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "THE ARMORY",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 44,
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
