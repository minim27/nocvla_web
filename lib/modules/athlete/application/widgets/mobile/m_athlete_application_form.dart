import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/athlete/application/athlete_application_controller.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

class MAthleteApplicationForm extends StatelessWidget {
  const MAthleteApplicationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AthleteApplicationController>();

    return Column(
      spacing: 16,
      children: [
        MyTextFormField(
          controller: controller.txtName,
          keyboardType: .name,
          textInputAction: .next,
          label: "FULL NAME",
          hintText: "Enter your full name",
        ),
        MyTextFormField(
          controller: controller.txtEmail,
          keyboardType: .emailAddress,
          textInputAction: .next,
          label: "EMAIL",
          hintText: "Enter your email",
        ),
        MyTextFormField(
          controller: controller.txtPhone,
          keyboardType: .phone,
          textInputAction: .next,
          label: "PHONE / WHATSAPP",
          hintText: "Enter your phone/WA number",
        ),
        MyTextFormField(
          controller: controller.txtInstagram,
          keyboardType: .text,
          textInputAction: .next,
          label: "INSTAGRAM USERNAME",
          hintText: "Enter your Instagram username",
        ),
        MyTextFormField(
          controller: controller.txtTiktok,
          keyboardType: .text,
          textInputAction: .next,
          label: "TIKTOK USERNAME",
          hintText: "Enter your TikTok username",
        ),
        MyTextFormField(
          controller: controller.txtCity,
          keyboardType: .text,
          textInputAction: .next,
          label: "CITY",
          hintText: "Enter your city",
        ),
        MyTextFormField(
          controller: controller.txtReason,
          keyboardType: .text,
          textInputAction: .done,
          label: "WHY DO YOU WANT TO JOIN?",
          hintText: "Tell us why you want to join",
          maxLines: 5,
        ),
        Obx(
          () => MyButton(
            height: 52,
            "SUBMIT APPLICATION",
            enable: !controller.isLoadingSubmit.value,
            onTap: () => controller.submit(),
          ),
        ),
      ],
    );
  }
}
