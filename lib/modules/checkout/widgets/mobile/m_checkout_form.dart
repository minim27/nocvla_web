import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/modules/checkout/checkout_controller.dart';
import 'package:nocvla_web/shared/widgets/my_text_form_field.dart';

import '../../../../shared/widgets/my_text.dart';

class MCheckoutForm extends StatelessWidget {
  const MCheckoutForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();

    return Column(
      crossAxisAlignment: .start,
      spacing: 16,
      children: [
        MyText(text: "DATA PENGIRIMAN", fontWeight: .w600, fontSize: 16),
        MyTextFormField(
          controller: controller.txtName,
          keyboardType: .name,
          textInputAction: .next,
          label: "NAMA PENERIMA",
          hintText: "Nama penerima",
        ),
        MyTextFormField(
          controller: controller.txtPhone,
          keyboardType: .phone,
          textInputAction: .next,
          label: "NO HP / WA",
          hintText: "Nomor HP atau WhatsApp",
        ),
        MyTextFormField(
          controller: controller.txtAddress,
          keyboardType: .streetAddress,
          textInputAction: .next,
          label: "ALAMAT LENGKAP",
          hintText: "Alamat lengkap pengiriman",
          maxLines: 5,
        ),
        MyTextFormField(
          controller: controller.txtNotes,
          keyboardType: .text,
          textInputAction: .done,
          label: "CATATAN (OPSIONAL)",
          hintText: "Catatan untuk admin",
        ),
      ],
    );
  }
}
