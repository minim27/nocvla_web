import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/data/models/me/me_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../app/core/base_controller.dart';

class MyProfileController extends BaseController {
  var res = <MeModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var txtFirstName = TextEditingController();
  var txtLastName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPhone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;
    var req = await meRepo.me();
    await req.responseHandler(
      res: (res) {
        this.res.add(MeModel.fromJson(res["data"]));

        txtFirstName.text = this.res[0].firstName;
        txtLastName.text = this.res[0].lastName;
        txtEmail.text = this.res[0].email;
        txtPhone.text = this.res[0].phoneNumber;
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }

  updateData() async {
    isLoadingAction.value = true;
    var req = await meRepo.updateProfile(
      data: {
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "email": txtEmail.text,
        "phone_number": txtPhone.text,
      },
    );
    await req.responseHandler(
      res: (res) => showSnackbar(msg: res["message"]),
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoadingAction.value = false;
  }
}
