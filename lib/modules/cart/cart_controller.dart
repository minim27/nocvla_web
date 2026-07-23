import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla_web/app/routes/my_routes.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_dummies.dart';

class CartController extends BaseController {
  final res = <Map<String, dynamic>>[
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "label": "COMPRESSION 1",
      "color": "BLACK",
      "size": "M",
      "price": 275000,
      "qty": 1.obs,
    },
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "label": "COMPRESSION 2",
      "color": "BLACK",
      "size": "L",
      "price": 275000,
      "qty": 2.obs,
    },
  ];

  final txtCode = TextEditingController();

  final refreshSubtotal = 0.obs;

  int get subTotal => res.fold(
    0,
    (total, item) =>
        total + (item["price"] as int) * (item["qty"] as RxInt).value,
  );

  void decrease(RxInt val) {
    if (val.value > 1) {
      val.value--;
      refreshSubtotal.value++;
    }
  }

  void increase(RxInt val) {
    val.value++;
    refreshSubtotal.value++;
  }

  void checkout() => Get.toNamed(MyRoutes.checkout);
}
