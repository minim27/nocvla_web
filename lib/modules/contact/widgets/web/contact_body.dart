import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/my_colors.dart';
import '../../../../shared/utils/my_fonts.dart';
import '../../../../shared/utils/my_icons.dart';
import '../../../../shared/widgets/my_button.dart';
import '../../../../shared/widgets/my_image.dart';
import '../../../../shared/widgets/my_text.dart';
import '../../../../shared/widgets/my_text_form_field.dart';
import '../../contact_controller.dart';

class ContactBody extends StatelessWidget {
  const ContactBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1240 + 48 * 2),
        child: Padding(
          padding: .fromLTRB(48, 48, 48, 112),
          child: SizedBox(
            width: .infinity,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Obx(() {
                  final contact = controller.resContact;

                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      if (contact["CONTACT_EYEBROW"] != null) ...[
                        MyText(
                          text: contact["CONTACT_EYEBROW"]!.toUpperCase(),
                          fontFamily: MyFonts.archivoNarrow,
                          fontSize: 12,
                          fontWeight: .w700,
                          letterSpacing: 12 * 0.3,
                          color: MyColors.white2,
                        ),
                        SizedBox(height: 10),
                      ],
                      if (contact["CONTACT_TITLE"] != null) ...[
                        MyText(
                          text: contact["CONTACT_TITLE"]!,
                          fontFamily: MyFonts.grenzeGotisch,
                          fontSize: 93.5,
                          fontWeight: .w700,
                          height: 1.05,
                        ),
                        SizedBox(height: 6),
                      ],
                      if (contact["CONTACT_DESCRIPTION"] != null)
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 560),
                          child: MyText(
                            text: contact["CONTACT_DESCRIPTION"]!,
                            fontSize: 16.5,
                            height: 1.75,
                            color: MyColors.white3,
                          ),
                        ),
                    ],
                  );
                }),
                SizedBox(height: 48),
                Row(
                  crossAxisAlignment: .start,
                  spacing: 56,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          Obx(() {
                            final channels = controller.channels;
                            if (channels.isEmpty) return SizedBox();

                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                for (final item in channels)
                                  LayoutBuilder(
                                    builder: (context, constraints) => SizedBox(
                                      width: (constraints.maxWidth - 12) / 2,
                                      child: channel(controller, item),
                                    ),
                                  ),
                              ],
                            );
                          }),
                          Obx(() {
                            if (controller.resFaq.isEmpty) return SizedBox();

                            return Container(
                              margin: .only(top: 32),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: MyColors.line2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: .stretch,
                                children: [
                                  Padding(
                                    padding: .only(top: 19, bottom: 8),
                                    child: MyText(
                                      text: "PERTANYAAN UMUM",
                                      fontFamily: MyFonts.archivoNarrow,
                                      fontSize: 13,
                                      fontWeight: .w700,
                                      letterSpacing: 13 * 0.22,
                                    ),
                                  ),
                                  for (final (i, item)
                                      in controller.resFaq.indexed)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: MyColors.line2,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: .stretch,
                                        children: [
                                          GestureDetector(
                                            behavior: .opaque,
                                            onTap: () =>
                                                controller.toggleFaq(i),
                                            child: Padding(
                                              padding: .symmetric(vertical: 18),
                                              child: Row(
                                                spacing: 12,
                                                children: [
                                                  Expanded(
                                                    child: MyText(
                                                      text: item.$1,
                                                      fontSize: 14,
                                                      fontWeight: .w700,
                                                    ),
                                                  ),
                                                  Icon(
                                                    controller.openFaq.value ==
                                                            i
                                                        ? Icons.remove
                                                        : Icons.add,
                                                    color: MyColors.white,
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (controller.openFaq.value == i &&
                                              item.$2.isNotEmpty)
                                            Padding(
                                              padding: .only(bottom: 16),
                                              child: MyText(
                                                text: item.$2,
                                                fontSize: 13.5,
                                                height: 1.75,
                                                color: MyColors.white3,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: .all(32),
                        decoration: BoxDecoration(
                          color: MyColors.black4,
                          border: .all(color: MyColors.line2),
                        ),
                        child: Obx(() {
                          if (controller.isSubmitted.value) {
                            return MyText(
                              text:
                                  "Pesan kamu sudah kami terima. Admin NOCVLA akan membalas lewat kontak yang kamu tulis.",
                              fontSize: 15,
                              height: 1.6,
                              color: MyColors.green,
                            );
                          }

                          return Column(
                            crossAxisAlignment: .stretch,
                            spacing: 18,
                            children: [
                              MyText(
                                text: "Kirim pesan",
                                fontFamily: MyFonts.grenzeGotisch,
                                fontSize: 30,
                                fontWeight: .w700,
                                height: 1,
                              ),
                              Row(
                                crossAxisAlignment: .start,
                                spacing: 14,
                                children: [
                                  Expanded(
                                    child: field(
                                      controller.txtName,
                                      "Nama",
                                      "Nama kamu",
                                    ),
                                  ),
                                  Expanded(
                                    child: field(
                                      controller.txtContact,
                                      "Email atau WhatsApp",
                                      "Agar kami bisa membalas",
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.resTopics.isNotEmpty)
                                Column(
                                  crossAxisAlignment: .stretch,
                                  spacing: 8,
                                  children: [
                                    label("Topik"),
                                    Container(
                                      height: 48,
                                      padding: .symmetric(horizontal: 18),
                                      decoration: BoxDecoration(
                                        color: MyColors.black5,
                                        border: .all(
                                          color: MyColors.swatchBorder,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: controller.topic.value,
                                          isExpanded: true,
                                          dropdownColor: MyColors.black5,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: MyColors.white,
                                            size: 18,
                                          ),
                                          items: [
                                            for (final item
                                                in controller.resTopics)
                                              DropdownMenuItem(
                                                value: item,
                                                child: MyText(
                                                  text: item,
                                                  fontSize: 14,
                                                  fontWeight: .w600,
                                                ),
                                              ),
                                          ],
                                          onChanged: (value) =>
                                              controller.topic.value = value,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              field(
                                controller.txtMessage,
                                "Pesan",
                                "Tulis pesanmu",
                                maxLines: 4,
                              ),
                              MyButton(
                                "KIRIM PESAN",
                                enable: !controller.isLoadingSubmit.value,
                                fontSize: 14,
                                fontWeight: .w700,
                                onTap: controller.submit,
                              ),
                              MyText(
                                text:
                                    "Pesan masuk ke admin NOCVLA. Untuk order, WhatsApp lebih cepat.",
                                fontSize: 12.5,
                                color: MyColors.white4,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget channel(
    ContactController controller,
    ({
      IconData? icon,
      String? asset,
      String label,
      String desc,
      String link,
      bool isMain,
    })
    item,
  ) {
    final color = item.isMain ? MyColors.redText : MyColors.white;

    return GestureDetector(
      onTap: () => controller.open(item.link),
      child: Container(
        height: 123,
        padding: .symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: MyColors.black4,
          border: .all(color: item.isMain ? MyColors.red : MyColors.line2),
        ),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: item.icon != null
                  ? Icon(item.icon, color: color, size: 20)
                  : MyImageAssets(
                      item.asset == "instagram"
                          ? MyIcons.icInstagram
                          : MyIcons.icTikTok,
                      fit: .contain,
                      color: color,
                    ),
            ),
            SizedBox(height: 14),
            MyText(
              text: item.label,
              fontFamily: MyFonts.archivoNarrow,
              fontSize: 13,
              fontWeight: .w700,
              letterSpacing: 13 * 0.22,
            ),
            SizedBox(height: 8),
            MyText(
              text: item.desc,
              fontSize: 14,
              color: MyColors.white2,
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String text) =>
      MyText(text: text, fontSize: 13, height: 1, color: MyColors.white2);

  Widget field(
    TextEditingController controller,
    String label,
    String hintText, {
    int maxLines = 1,
  }) {
    return MyTextFormField(
      controller: controller,
      keyboardType: maxLines > 1 ? .multiline : .text,
      textInputAction: maxLines > 1 ? .newline : .next,
      label: label,
      hintText: hintText,
      maxLines: maxLines,
      labelFontSize: 13,
      labelFontWeight: .w400,
      fontSize: 14,
      fillColor: MyColors.black5,
      borderColor: MyColors.swatchBorder,
      hintColor: MyColors.placeholder,
      padding: .symmetric(horizontal: 15, vertical: maxLines > 1 ? 18 : 12.5),
    );
  }
}
