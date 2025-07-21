import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/modules/dashboard/dashboard_args.dart';
import 'package:nocvla/shared/utils/my_audios.dart';

import '../../app/routes/my_routes.dart';
import '../home/home_page.dart';
import '../../app/core/base_controller.dart';

class DashboardController extends BaseController {
  List<Map<String, dynamic>> menuDashboard = [
    {"title": "Home Page".tr},
  ];

  List<Widget> pageList = [HomePage()];

  var currentIndex = 0.obs;

  final AudioPlayer _player = AudioPlayer();

  @override
  void onInit() {
    if (Get.arguments == null) {
      currentIndex.value = 0;
    } else {
      final args = Get.arguments as DashboardArgs;
      currentIndex.value = args.index;
    }
    super.onInit();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _initAudio() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource(MyAudios.audBG), volume: 1);
  }

  void enterSite() async {
    await _initAudio();
    Get.offAllNamed(MyRoutes.dashboard, arguments: DashboardArgs(index: 0));
  }

  void changeMenuSelected({required int idx}) => currentIndex.value = idx;
}
