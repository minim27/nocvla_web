import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/utils/my_colors.dart';

import '../base_controller.dart';

class HomeController extends BaseController {
  final List<Color> listColors = [
    MyColors.secondary,
    MyColors.pink,
    MyColors.red,
    MyColors.purple,
    MyColors.yellow,
  ];

  var currentColorIndex = 0.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      currentColorIndex.value =
          (currentColorIndex.value + 1) % listColors.length;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
