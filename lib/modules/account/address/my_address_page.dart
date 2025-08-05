import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/account/address/my_address_controller.dart';
import 'package:nocvla/shared/utils/my_fonts.dart';
import 'package:nocvla/shared/widgets/my_button.dart';
import 'package:nocvla/shared/widgets/my_loading.dart';
import 'package:nocvla/shared/widgets/my_scaffold.dart';
import 'package:nocvla/shared/widgets/my_text.dart';

import '../../../shared/utils/my_images.dart';
import '../../../shared/widgets/my_image.dart';
import '../../../shared/widgets/my_text_form_field.dart';

class MyAddressPage extends GetView<MyAddressController> {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          appBar: AppBar(
            title: SizedBox(
              width: 70,
              child: MyImageAssets(assets: MyImages.imgNocvla),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            if (controller.isLoading.value) return MyLoading();

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                MyText(
                  text: "Address",
                  fontSize: 24,
                  fontFamily: MyFonts.libreBaskerville,
                ),
                SizedBox(height: 24),
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
                SizedBox(height: 32),
                MyButton(text: "Update", onTap: () => controller.updateData()),
              ],
            );
          }),
        ),
        Obx(
          () => Visibility(
            visible: controller.isLoadingAction.value,
            child: const MyLoading(isStack: true),
          ),
        ),
      ],
    );
  }
}
