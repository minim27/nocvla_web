import 'package:flutter/material.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_max_width.dart';
import '../../../../shared/widgets/my_text.dart';

class CollectionHeader extends StatelessWidget {
  const CollectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return MyMaxWidth(
      child: Padding(
        padding: .only(top: 48, bottom: 34),
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
              fontSize: 86,
              fontWeight: .w700,
              height: 1.05,
            ),
            SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 560),
              child: MyText(
                text:
                    "Setiap seri punya beberapa colorway dengan artwork sablon berbeda. Pilih warnanya, lalu order via WhatsApp atau marketplace.",
                fontSize: 15.5,
                height: 1.6,
                color: MyColors.white2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
