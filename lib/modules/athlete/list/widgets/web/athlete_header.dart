import 'package:flutter/material.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';

import '../../../../../shared/utils/my_colors.dart';

class AthleteHeader extends StatelessWidget {
  const AthleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(40, 80, 40, 0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "NOCVLA ATHLETE",
            fontSize: 42,
            letterSpacing: 2,
            fontFamily: MyFonts.grenzeGotisch,
          ),
          MyText(
            text: "They Represent. We Support.",
            fontSize: 16,
            color: MyColors.white2,
          ),
        ],
      ),
    );
  }
}
