import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
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
          "name": "ArchMage Compressed Premium",
          "slug": "archmage-compressed-premium",
          "src":
              "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        },
        "products": [
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
        ],
      },
      "product2": {
        "image": {
          "id": 1,
          "name": "ArchMage Compressed Premium",
          "slug": "archmage-compressed-premium",
          "src":
              "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
        },
        "products": [
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://i.scdn.co/image/ab67616d0000b27323a8321bd17fe693210812fe",
          },
        ],
      },
      "product3": {
        "image": {
          "id": 1,
          "name": "ArchMage Compressed Premium",
          "slug": "archmage-compressed-premium",
          "src":
              "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
        },
        "products": [
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
                "https://assets.mediamodifier.com/mockups/64e9a065c9d68217ad1458ba/back-view-of-t-shirt-mockup-on-african-american-male-model.jpg",
          },
          {
            "id": 1,
            "name": "ArchMage Compressed Premium",
            "slug": "archmage-compressed-premium",
            "image":
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

  void openDetail({required String slug}) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"slug": slug});
}
