import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/data/models/order/checkout_model.dart';
import 'package:nocvla/data/models/order/payment_method_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../../app/services/my_config.dart';
import '../../../data/models/order/cart_model.dart';
import '../../../shared/utils/my_getstorage.dart';

class CheckoutController extends BaseController {
  var resProduct = <CartModel>[];
  var resPayMethod = <PaymentMethodModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;
  var isLogin = false.obs;
  var isObscure = true.obs;

  var txtFirstName = TextEditingController();
  var txtLastName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var txtPhone = TextEditingController();
  var txtCity = TextEditingController();
  var txtDistrict = TextEditingController();
  var txtVillage = TextEditingController();
  var txtAddress = TextEditingController();
  var txtPostalCode = TextEditingController();
  var txtNote = TextEditingController();

  var selectedPayMet = Rxn<String>();

  var totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApi();
  }

  fetchApi() async {
    isLoading.value = true;

    var token = await MyGetStorage.getString(key: MyConfig.keyAccessToken);
    if (token != null) isLogin.value = true;

    var reqCart = await orderRepo.listCart();
    var reqPayment = await orderRepo.paymentMethod();

    await reqCart.responseHandler(
      res: (res) {
        List<CartModel> result = [];

        totalPrice.value = res["data"]["total_amount"];

        for (var data in res["data"]["items"]) {
          result.add(CartModel.fromJson(data));
        }

        resProduct.assignAll(result);
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    await reqPayment.responseHandler(
      res: (res) {
        List<PaymentMethodModel> result = [];

        for (var data in res["data"]) {
          result.add(PaymentMethodModel.fromJson(data));
        }

        resPayMethod.assignAll(result);
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoading.value = false;
  }

  void selectPayMet({required PaymentMethodModel res}) =>
      selectedPayMet.value = res.bankCode;

  void checkout() async {
    isLoadingAction.value = true;

    Map<String, dynamic> body = {};

    var items = <Map<String, dynamic>>[];
    for (var data in resProduct) {
      items.add({
        "product_name": data.product["name"],
        "product_id": data.product["id"],
        "variation_id": data.product["size"]["id"],
        "color_id": data.product["color"]["id"],
        "print_id": data.product["print_id"],
        "qty": data.qty,
        "price": data.product["price"],
        "note": data.note,
      });
    }

    if (isLogin.value) {
      body = {
        "payment_method_code": selectedPayMet.value,
        "shipping_id": null,
        "note": txtNote.text,
        "items": items,
      };
    } else {
      body = {
        "payment_method_code": selectedPayMet.value,
        "shipping_id": null,
        "first_name": txtFirstName.text,
        "last_name": txtLastName.text,
        "email": txtEmail.text,
        "password": txtPassword.text,
        "phone_number": txtPhone.text,
        "city": txtCity.text,
        "district": txtDistrict.text,
        "village": txtVillage.text,
        "address": txtAddress.text,
        "postal_code": txtPostalCode.text,
        "note": txtNote.text,
        "items": items,
      };
    }

    var req = await orderRepo.checkout(data: body);
    await req.responseHandler(
      res: (res) async {
        List<CheckoutModel> result = [];
        result.add(CheckoutModel.fromJson(res["data"]));

        if (result[0].accessToken != null) {
          await MyGetStorage.setValue(
            key: MyConfig.keyAccessToken,
            value: result[0].accessToken,
          );
        }

        Get.offAllNamed(MyRoutes.dashboard);
      },
      err: (err) => showErrSnackbar(msg: err),
    );
    isLoadingAction.value = false;
  }
}
