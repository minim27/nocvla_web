import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/data/models/me/me_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../app/core/base_controller.dart';

class MyPasswordController extends BaseController {
  var res = <MeModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var isOldObscure = true.obs;
  var isNewObscure = true.obs;
  var isConfObscure = true.obs;

  var txtOldPassword = TextEditingController();
  var txtNewPassword = TextEditingController();
  var txtConfPassword = TextEditingController();

  updateData() async {
    isLoadingAction.value = true;
    var req = await meRepo.updatePassword(
      data: {
        "old_password": txtOldPassword.text,
        "new_password": txtNewPassword.text,
        "confirm_password": txtConfPassword.text,
      },
    );
    await req.responseHandler(
      res: (res) => showSnackbar(msg: res["message"]),
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoadingAction.value = false;
  }
}
