import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/app/routes/my_routes.dart';
import 'package:nocvla/data/models/home_model.dart';
import 'package:nocvla/shared/utils/my_colors.dart';
import 'package:nocvla/shared/utils/my_utility.dart';

import '../../app/core/base_controller.dart';

class HomeController extends BaseController {
  var resAD = <HomeADModel>[];
  var resContent = <HomeContentModel>[];

  var isLoading = false.obs;
  var isLoadingAction = false.obs;

  var txtEmail = TextEditingController();

  final List<Color> listColors = [
    MyColors.secondary,
    MyColors.pink,
    MyColors.red,
    MyColors.purple,
    MyColors.yellow,
  ];

  var currentColorIndex = 0.obs;
  late Timer timer;

  var availableDate = Rxn<DateTime>();
  var remaining = Duration.zero.obs;
  late Timer timerAvailable;

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
    timerAvailable.cancel();
    super.dispose();
  }

  void startCountdown(DateTime targetDate) {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = targetDate.difference(now);

      if (diff.isNegative) {
        timer.cancel();
        remaining.value = Duration.zero;
      } else {
        remaining.value = diff;
      }

      update(); // pakai GetX update
    });
  }

  void startCountdownAvailable(DateTime target) {
    timerAvailable = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = target.difference(now);

      remaining.value = diff.isNegative ? Duration.zero : diff;
    });
  }

  fetchApi() async {
    isLoading.value = true;

    var req = await homeRepo.home();

    await req.responseHandler(
      res: (res) {
        List<HomeContentModel> result = [];
        for (Map<String, dynamic> data in res["data"]["content"]) {
          result.add(HomeContentModel.fromJson(data));
        }

        resContent.assignAll(result);
        resAD.add(HomeADModel.fromJson(res["data"]));
      },
      err: (err) => showErrSnackbar(msg: err["message"]),
    );

    availableDate.value = DateTime.parse(resAD[0].availableDate).toLocal();

    if (DateTime.now().isBefore(availableDate.value!)) {
      startCountdownAvailable(availableDate.value!);
    }

    isLoading.value = false;
  }

  void notifyMe() async {
    isLoadingAction.value = true;
    
    isLoadingAction.value = false;
  }

  void openDetail({required String slug}) =>
      Get.toNamed(MyRoutes.productDetail, parameters: {"slug": slug});
}
