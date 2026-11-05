import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/utils/my_colors.dart';
import '../../../../../shared/utils/my_fonts.dart';
import '../../../../../shared/widgets/my_button.dart';
import '../../../../../shared/widgets/my_dash_border.dart';
import '../../../../../shared/widgets/my_text.dart';
import '../../../../../shared/widgets/my_text_form_field.dart';
import '../../athlete_controller.dart';

class TAthleteJoin extends StatelessWidget {
  const TAthleteJoin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteController>();

    return Container(
      key: controller.formKey,
      decoration: BoxDecoration(
        color: MyColors.black4,
        border: Border(top: BorderSide(color: MyColors.line2)),
      ),
      child: Padding(
        padding: .fromLTRB(40, 80, 40, 80),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 32,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                MyText(
                  text: "Join Nocvla Athlete",
                  fontFamily: MyFonts.grenzeGotisch,
                  fontSize: 52,
                  fontWeight: .w700,
                  height: 1.05,
                ),
                SizedBox(height: 19),
                MyText(
                  text:
                      "Kami mencari individu yang berkomitmen pada disiplin, konsistensi, dan progres tanpa kompromi. Bergabunglah dan representasikan standar yang lebih tinggi.",
                  fontSize: 16,
                  height: 1.7,
                  color: MyColors.white3,
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.black3,
                    border: .all(color: MyColors.line2),
                  ),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      for (var i = 0; i < controller.benefits.length; i += 2)
                        Container(
                          decoration: BoxDecoration(
                            border: i == 0
                                ? null
                                : Border(
                                    top: BorderSide(color: MyColors.line2),
                                  ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: .stretch,
                              children: [
                                Expanded(
                                  child: benefit(controller.benefits[i]),
                                ),
                                Container(width: 1, color: MyColors.line2),
                                Expanded(
                                  child: benefit(controller.benefits[i + 1]),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: .all(32),
              decoration: BoxDecoration(
                color: MyColors.black3,
                border: .all(color: MyColors.line2),
              ),
              child: form(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget benefit((String, String) item) {
    return Padding(
      padding: .symmetric(horizontal: 20, vertical: 19.5),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 4,
        children: [
          MyText(
            text: item.$1,
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 14,
            fontWeight: .w700,
            letterSpacing: 14 * 0.145,
          ),
          MyText(text: item.$2, fontSize: 13.5, color: MyColors.white2),
        ],
      ),
    );
  }

  Widget field({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return MyTextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
      padding: .symmetric(horizontal: 15, vertical: maxLines > 1 ? 12.5 : 13.5),
    );
  }

  Widget label(String text) =>
      MyText(text: text, fontSize: 12.5, height: 1, color: MyColors.white2);

  Widget form(AthleteController controller) {
    return Obx(() {
      if (controller.isSubmitted.value) {
        return MyText(
          text:
              "Pendaftaran kamu sudah kami terima. Tim NOCVLA akan menghubungi via WhatsApp setelah pendaftaran ditinjau.",
          fontSize: 15,
          height: 1.6,
          color: MyColors.green,
        );
      }

      final photo = controller.photo.value;

      return Column(
        crossAxisAlignment: .stretch,
        spacing: 18,
        children: [
          MyText(
            text: "FORMULIR PENDAFTARAN",
            fontFamily: MyFonts.archivoNarrow,
            fontSize: 13,
            fontWeight: .w700,
            letterSpacing: 13 * 0.235,
            height: 1,
          ),
          Row(
            spacing: 16,
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: field(
                  controller: controller.txtName,
                  keyboardType: .name,
                  label: "Nama lengkap",
                  hintText: "Nama sesuai identitas",
                ),
              ),
              Expanded(
                child: field(
                  controller: controller.txtCity,
                  keyboardType: .text,
                  label: "Kota",
                  hintText: "Contoh: Bandung",
                ),
              ),
            ],
          ),
          Row(
            spacing: 16,
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: field(
                  controller: controller.txtInstagram,
                  keyboardType: .text,
                  label: "Instagram",
                  hintText: "@username",
                ),
              ),
              Expanded(
                child: field(
                  controller: controller.txtPhone,
                  keyboardType: .phone,
                  label: "Nomor WhatsApp",
                  hintText: "08xx",
                ),
              ),
            ],
          ),
          if (controller.resFocuses.isNotEmpty)
            Column(
              crossAxisAlignment: .stretch,
              spacing: 8,
              children: [
                label("Fokus latihan"),
                Container(
                  height: 48,
                  padding: .symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: MyColors.black5,
                    border: .all(color: MyColors.swatchBorder),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.trainingFocus.value,
                      isExpanded: true,
                      dropdownColor: MyColors.black5,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.white,
                        size: 18,
                      ),
                      items: [
                        for (final item in controller.resFocuses)
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
                          controller.trainingFocus.value = value,
                    ),
                  ),
                ),
              ],
            ),
          field(
            controller: controller.txtReason,
            keyboardType: .multiline,
            label: "Kenapa kamu cocok jadi atlet NOCVLA?",
            hintText: "Ceritakan perjalanan latihanmu",
            maxLines: 3,
          ),
          Column(
            crossAxisAlignment: .stretch,
            spacing: 8,
            children: [
              label("Foto diri (opsional)"),
              GestureDetector(
                behavior: .opaque,
                onTap: controller.pickPhoto,
                child: SizedBox(
                  height: 74,
                  child: MyDashBorder(
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          color: MyColors.white2,
                          size: 18,
                        ),
                        Flexible(
                          child: MyText(
                            text: photo?.name ?? "Unggah JPG / PNG",
                            fontSize: 13.6,
                            color: MyColors.white2,
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          MyButton(
            "KIRIM PENDAFTARAN",
            enable: !controller.isLoadingSubmit.value,
            fontSize: 15.4,
            fontWeight: .w700,
            onTap: controller.submit,
          ),
          MyText(
            text:
                "Tim NOCVLA akan menghubungi via WhatsApp setelah pendaftaran ditinjau.",
            fontSize: 12.5,
            color: MyColors.white4,
          ),
        ],
      );
    });
  }
}
