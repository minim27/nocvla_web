import 'package:flutter/material.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_text.dart';

class TAthleteHeader extends StatelessWidget {
  const TAthleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line2)),
      ),
      child: Padding(
        padding: .fromLTRB(40, 40, 40, 28),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            MyText(
              text: "NOCVLA ATHLETE",
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 12,
              fontWeight: .w600,
              letterSpacing: 12 * 0.3,
              color: MyColors.white2,
            ),
            SizedBox(height: 12),
            MyText(
              text: "The Congregation",
              fontFamily: MyFonts.grenzeGotisch,
              fontSize: 60,
              fontWeight: .w700,
              height: 1.05,
            ),
            SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 560),
              child: MyText(
                text:
                    "They represent. We support. Pakai kode atlet saat order WhatsApp, atau beli lewat link marketplace mereka.",
                fontSize: 15,
                height: 1.7,
                color: MyColors.white3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
