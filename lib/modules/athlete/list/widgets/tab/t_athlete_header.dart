import 'package:flutter/material.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_text.dart';

class TAthleteHeader extends StatelessWidget {
  const TAthleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(40, 36, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "THE CONGREGATION",
            fontFamily: MyFonts.grenzeGotisch,
            fontSize: 56,
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
