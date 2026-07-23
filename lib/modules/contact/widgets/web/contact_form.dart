import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/contact/contact_controller.dart';
import 'package:nocvla_web/shared/widgets/my_button.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();

    return Expanded(
      child: Column(
        spacing: 16,
        children: [
          MyTextFormField(
            controller: controller.txtName,
            keyboardType: .name,
            textInputAction: .next,
            label: "YOUR NAME",
            hintText: "Masukkan nama kamu",
          ),
          MyTextFormField(
            controller: controller.txtEmail,
            keyboardType: .emailAddress,
            textInputAction: .next,
            label: "EMAIL",
            hintText: "Masukkan email kamu",
          ),
          MyTextFormField(
            controller: controller.txtSubject,
            keyboardType: .text,
            textInputAction: .next,
            label: "SUBJECT",
            hintText: "Masukkan subjek pesan",
          ),
          MyTextFormField(
            controller: controller.txtMessage,
            keyboardType: .text,
            textInputAction: .done,
            label: "MESSAGE",
            hintText: "Tulis pesan kamu disini",
            maxLines: 5,
          ),
          MyButton(height: 52, "SEND MESSAGE", onTap: () => controller.send()),
        ],
      ),
    );
  }
}
