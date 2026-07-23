import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/collection/collection_controller.dart';
import 'package:nocvla_web/shared/utils/my_colors.dart';
import 'package:nocvla_web/shared/utils/my_fonts.dart';
import 'package:nocvla_web/shared/utils/my_icons.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_image.dart';
import 'package:nocvla_web/shared/widgets/my_text.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../../../../shared/widgets/my_divider.dart';

class MCollectionBottom extends StatelessWidget {
  const MCollectionBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();

    return Column(
      children: [
        MyDivider(),
        Padding(
          padding: .all(48),
          child: Row(
            spacing: 36,
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                spacing: 24,
                children: [
                  MyImageAssets(MyIcons.icEmail),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      MyText(
                        text: "JOIN NOCVLA",
                        fontWeight: .w600,
                        fontFamily: MyFonts.bebasNeue,
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                      MyText(
                        text: "Be the first to know",
                        color: MyColors.white.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    Flexible(
                      child: MyTextFormField(
                        width: 400,
                        height: 48,
                        controller: controller.txtEmail,
                        readOnly: true,
                        textAlign: .left,
                        onTap: () => controller.copyDiscordLink(),
                      ),
                    ),
                    MyButtonIcon(
                      width: 48,
                      height: 48,
                      MyIcons.icForward,
                      onTap: () => controller.openDiscordLink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MyDivider(),
      ],
    );
  }
}
