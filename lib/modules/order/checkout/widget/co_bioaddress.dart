import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla/shared/utils/my_utility.dart';
import 'package:nocvla/shared/widgets/my_text_form_field.dart';

import '../checkout_controller.dart';

class COBioAddress extends GetView<CheckoutController> {
  const COBioAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: MyTextFormField(
                controller: controller.txtFirstName,
                label: "First Name",
                labelFontWeight: FontWeight.w500,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ),
            Expanded(
              child: MyTextFormField(
                controller: controller.txtLastName,
                label: "Last Name",
                labelFontWeight: FontWeight.w500,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtEmail,
          label: "Email",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          isPassword: true,
          obscureText: controller.isObscure.value,
          controller: controller.txtPassword,
          label: "Password",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          icPassOnTap: () => changeStatusBool(val: controller.isObscure),
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtPhone,
          label: "Phone",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtCity,
          label: "Kota/Kabupaten",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtDistrict,
          label: "Kecamatan",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtVillage,
          label: "Kelurahan",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtAddress,
          label: "Alamat Lengkap",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12),
        MyTextFormField(
          controller: controller.txtPostalCode,
          label: "Kode Pos",
          labelFontWeight: FontWeight.w500,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
