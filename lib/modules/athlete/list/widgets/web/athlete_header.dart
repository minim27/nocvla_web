import 'package:flutter/material.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_text.dart';

class AthleteHeader extends StatelessWidget {
  const AthleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(40, 40, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "THE CONGREGATION",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 64,
            fontWeight: .w600,
          ),
          MyText(
            text: "Atlet yang berlatih bersama NOCVLA.",
            fontSize: 16,
            color: MyColors.white2,
          ),
        ],
      ),
    );
  }
}
