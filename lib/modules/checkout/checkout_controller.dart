import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/core/base_controller.dart';
import '../../shared/utils/my_dummies.dart';

class CheckoutController extends BaseController {
  final res = <Map<String, dynamic>>[
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "label": "COMPRESSION 1",
      "color": "BLACK",
      "size": "M",
      "price": 275000,
      "qty": 1,
    },
    {
      "id": "123",
      "image": MyDummies.dumBaju,
      "label": "COMPRESSION 2",
      "color": "BLACK",
      "size": "L",
      "price": 275000,
      "qty": 2,
    },
  ];

  final txtName = TextEditingController();
  final txtPhone = TextEditingController();
  final txtAddress = TextEditingController();
  final txtCity = TextEditingController();
  final txtPostalCode = TextEditingController();
  final txtNotes = TextEditingController();

  final refreshSubtotal = 0.obs;

  int get subTotal => res.fold(
    0,
    (total, item) => total + (item["price"] as int) * (item["qty"] as int),
  );
}
