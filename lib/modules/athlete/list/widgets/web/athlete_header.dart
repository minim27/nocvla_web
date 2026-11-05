import 'package:flutter/material.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_max_width.dart';
import '../../../../../shared/widgets/my_text.dart';

class AthleteHeader extends StatelessWidget {
  const AthleteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line2)),
      ),
      child: MyMaxWidth(
        child: Padding(
          padding: .only(top: 48, bottom: 34),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              MyText(
                text: "NOCVLA ATHLETE",
                fontFamily: MyFonts.archivoNarrow,
                fontSize: 13,
                fontWeight: .w700,
                letterSpacing: 13 * 0.23,
                color: MyColors.white2,
              ),
              SizedBox(height: 10),
              MyText(
                text: "The Congregation",
                fontFamily: MyFonts.grenzeGotisch,
                fontSize: 93.5,
                fontWeight: .w700,
                height: 1.05,
              ),
              SizedBox(height: 6),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 560),
                child: MyText(
                  text:
                      "They represent. We support. Pakai kode atlet saat order WhatsApp, atau beli lewat link marketplace mereka.",
                  fontSize: 16.5,
                  height: 1.7,
                  color: MyColors.white3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
