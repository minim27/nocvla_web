import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/contact/contact_controller.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/widgets/my_text.dart';

class ContactSosmed extends StatelessWidget {
  const ContactSosmed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();

    return Expanded(
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        spacing: 38,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              MyText(
                text: "CONTACT US",
                fontSize: 42,
                letterSpacing: 2,
                fontFamily: MyFonts.bebasNeue,
              ),
              MyText(
                text:
                    "Punya pertanyaan atau ingin bekerja sama?\nHubungi kami melalui form atau media sosial.",
                fontSize: 16,
                color: MyColors.white2,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            spacing: 24,
            children: [
              ...controller.res.entries.map((entry) {
                final items = entry.value;

                return Row(
                  spacing: 12,
                  children: [
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: MyImageAssets(items["icon"], fit: .cover),
                    ),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        MyText(
                          text: items["label"],
                          fontSize: 16,
                          fontWeight: .w600,
                          letterSpacing: 1,
                        ),
                        MyText(
                          text: items["desc"],
                          color: MyColors.white2,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
