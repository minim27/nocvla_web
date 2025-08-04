import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/core/base_controller.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/data/models/order/cart_model.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

class CartController extends BaseController {
  var res = <CartModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var txtQty = <TextEditingController>[].obs;

  var totalPrice = 0.obs;

  final Map<int, Timer?> _timers = {};
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    fetchApi(isFirst: true);
  }

  fetchApi({bool isFirst = false}) async {
    if (isFirst) isLoading.value = true;

    res.clear();
    txtQty.clear();

    var req = await orderRepo.listCart();
    await req.responseHandler(
      res: (res) {
        List<CartModel> result = [];

        totalPrice.value = res["data"]["total_amount"];

        for (var data in res["data"]["items"]) {
          txtQty.add(TextEditingController(text: "${data["qty"]}"));
          result.add(CartModel.fromJson(data));
        }

        this.res.assignAll(result);
      },
      err: (err) => showErrSnackbar(msg: err),
    );

    if (isFirst) isLoading.value = false;
  }

  void decreaseQty({required int index, required CartModel res}) {
    int qty = int.tryParse(txtQty[index].text) ?? 1;
    if (qty > 1) {
      txtQty[index].text = "${qty - 1}";

      _timers[index]?.cancel();
      _timers[index] = Timer(Duration(seconds: 2), () async {
        isLoadingAction.value = true;

        var req = await orderRepo.updateCart(
          id: res.id,
          data: {
            "product_id": res.product["id"],
            "variation_id": res.product["size"]["id"],
            "color_id": res.product["color"]["id"],
            "print_id": res.product["print_id"],
            "qty": txtQty[index].text,
            "note": "",
          },
        );
        await req.responseHandler(
          res: (res) async {
            await fetchApi();
            isLoadingAction.value = false;
          },
          err: (err) {
            showErrSnackbar(msg: err);
            isLoadingAction.value = false;
          },
        );
      });
    }
  }

  void increaseQty({required int index, required CartModel res}) {
    int qty = int.tryParse(txtQty[index].text) ?? 1;
    txtQty[index].text = "${qty + 1}";

    _timers[index]?.cancel();
    _timers[index] = Timer(Duration(seconds: 2), () async {
      isLoadingAction.value = true;

      var req = await orderRepo.updateCart(
        id: res.id,
        data: {
          "product_id": res.product["id"],
          "variation_id": res.product["size"]["id"],
          "color_id": res.product["color"]["id"],
          "print_id": res.product["print_id"],
          "qty": txtQty[index].text,
          "note": "",
        },
      );
      await req.responseHandler(
        res: (res) async {
          await fetchApi();
          isLoadingAction.value = false;
        },
        err: (err) {
          showErrSnackbar(msg: err);
          isLoadingAction.value = false;
        },
      );
    });
  }

  void deleteCart({required CartModel res}) async {
    isLoadingAction.value = true;

    var req = await orderRepo.removeCart(id: res.id);
    await req.responseHandler(
      res: (res) => fetchApi(),
      err: (err) => showErrSnackbar(msg: err),
    );

    isLoadingAction.value = false;
  }

  void checkout() => Get.toNamed(MyRoutes.checkout);
}
