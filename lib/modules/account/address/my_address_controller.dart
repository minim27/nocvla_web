import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/data/models/me/my_address_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../app/core/base_controller.dart';

class MyAddressController extends BaseController {
  var res = <MyAddressModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var txtCity = TextEditingController();
  var txtDistrict = TextEditingController();
  var txtVillage = TextEditingController();
  var txtAddress = TextEditingController();
  var txtPostalCode = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;
    var req = await meRepo.myAddress();
    await req.responseHandler(
      res: (res) {
        this.res.add(MyAddressModel.fromJson(res["data"]));

        txtCity.text = this.res[0].city;
        txtDistrict.text = this.res[0].district;
        txtVillage.text = this.res[0].village;
        txtAddress.text = this.res[0].address;
        txtPostalCode.text = this.res[0].postalCode;
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }

  updateData() async {
    isLoadingAction.value = true;
    var req = await meRepo.updateAddress(
      data: {
        "city": txtCity.text,
        "district": txtDistrict.text,
        "village": txtVillage.text,
        "address": txtAddress.text,
        "postal_code": txtPostalCode.text,
      },
    );
    await req.responseHandler(
      res: (res) => showSnackbar(msg: res["message"]),
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoadingAction.value = false;
  }
}
