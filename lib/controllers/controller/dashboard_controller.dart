import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/utils/my_audios.dart';
import 'package:nocvla/views/dashboard_page.dart';

import '../../views/home_page.dart';
import '../base_controller.dart';

class DashboardController extends BaseController {
  List<Map<String, dynamic>> menuDashboard = [
    {"title": "Home Page".tr},
  ];

  List<Widget> pageList = [HomePage()];

  var currentIndex = Rxn<int>();

  final AudioPlayer _player = AudioPlayer();

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
    Get.offAll(
      DashboardPage(currentIndex: 0),
      transition: Transition.fadeIn,
    );
  }

  void changeMenuSelected({required int idx}) => currentIndex.value = idx;
}
