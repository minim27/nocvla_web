import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/base_controller.dart';
import '../../../shared/utils/my_utility.dart';

class AthleteApplicationController extends BaseController {
  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPhone = TextEditingController();
  final txtInstagram = TextEditingController();
  final txtTiktok = TextEditingController();
  final txtCity = TextEditingController();
  final txtReason = TextEditingController();

  final isLoadingSubmit = false.obs;

  bool validApplication() {
    if (txtName.text.trim().isEmpty ||
        txtEmail.text.trim().isEmpty ||
        txtPhone.text.trim().isEmpty ||
        txtInstagram.text.trim().isEmpty ||
        txtTiktok.text.trim().isEmpty ||
        txtCity.text.trim().isEmpty ||
        txtReason.text.trim().isEmpty) {
      showMyErrAPISnackbar({"message": "Semua field wajib diisi"});
      return false;
    }

    return true;
  }

  void submit() async {
    if (!validApplication()) return;
    isLoadingSubmit.value = true;

    final req = await athleteApplicationRepo.submitApplication(
      name: txtName.text.trim(),
      email: txtEmail.text.trim(),
      phone: txtPhone.text.trim(),
      instagramUsername: txtInstagram.text.trim(),
      tiktokUsername: txtTiktok.text.trim(),
      city: txtCity.text.trim(),
      reason: txtReason.text.trim(),
    );
    await req.responseHandler(
      res: (res) {
        Get.back();
        showMySnackbar("Berhasil", "Aplikasi kamu berhasil dikirim");
      },
      err: (err) => showMyErrAPISnackbar(err),
    );

    isLoadingSubmit.value = false;
  }
}
