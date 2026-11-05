import 'package:flutter/material.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';

class TCollectionHeader extends StatelessWidget {
  const TCollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(40, 40, 40, 28),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          MyText(
            text: "KOLEKSI",
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 12,
            fontWeight: .w600,
            letterSpacing: 12 * 0.3,
            color: MyColors.white2,
          ),
          SizedBox(height: 12),
          MyText(
            text: "The Armory",
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
                  "Setiap seri punya beberapa colorway dengan artwork sablon berbeda. Pilih warnanya, lalu order via WhatsApp atau marketplace.",
              fontSize: 15,
              height: 1.6,
              color: MyColors.white2,
            ),
          ),
        ],
      ),
    );
  }
}
