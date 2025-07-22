import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/data/models/home_model.dart';
import 'package:nocvla/shared/utils/my_colors.dart';

import '../../app/core/base_controller.dart';

class HomeController extends BaseController {
  dynamic json = {
    "success": true,
    "message": "OK",
    "data": {
      "product1": {
        "image": {
          "id": 1,
          "src":
              "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        },
        "products": [
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
        ],
      },
      "product2": {
        "image": {
          "id": 1,
          "src":
              "https://www.titanui.com/wp-content/uploads/2023/10/13/Cotton-T-shirt-Back-PSD-Mockup.jpg",
        },
        "products": [
          {
            "id": 1,
            "src":
                "https://www.titanui.com/wp-content/uploads/2023/10/13/Cotton-T-shirt-Back-PSD-Mockup.jpg",
          },
          {
            "id": 1,
            "src":
                "https://www.titanui.com/wp-content/uploads/2023/10/13/Cotton-T-shirt-Back-PSD-Mockup.jpg",
          },
          {
            "id": 1,
            "src":
                "https://www.titanui.com/wp-content/uploads/2023/10/13/Cotton-T-shirt-Back-PSD-Mockup.jpg",
          },
          {
            "id": 1,
            "src":
                "https://www.titanui.com/wp-content/uploads/2023/10/13/Cotton-T-shirt-Back-PSD-Mockup.jpg",
          },
        ],
      },
      "product3": {
        "image": {
          "id": 1,
          "src":
              "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        },
        "products": [
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "src":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
        ],
      },
    },
  };

  var res = <HomeModel>[];

  var isLoading = false.obs;

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
    fetchApi();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  fetchApi() async {
    isLoading.value = true;

    res.add(HomeModel.fromJson(json["data"]));

    isLoading.value = false;
  }

  void notifyMe() => null;
}
