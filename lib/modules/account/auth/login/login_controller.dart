import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/app/services/my_config.dart';
import 'package:nocvla/data/models/auth/login_model.dart';
import 'package:nocvla/shared/utils/my_getstorage.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../../app/core/base_controller.dart';

class LoginController extends BaseController {
  var isLoading = false.obs;

  var isObscure = true.obs;

  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();

  login() async {
    isLoading.value = true;
    var req = await authRepo.login(
      data: {
        "email": txtEmail.text,
        "password": txtPassword.text,
        "device_id": "",
      },
    );
    await req.responseHandler(
      res: (res) async {
        List<LoginModel> result = [];
        result.add(LoginModel.fromJson(res["data"]));

        await MyGetStorage.setValue(
          key: MyConfig.keyAccessToken,
          value: result[0].accessToken,
        );

        Get.offAllNamed(MyRoutes.dashboard);
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }
}
