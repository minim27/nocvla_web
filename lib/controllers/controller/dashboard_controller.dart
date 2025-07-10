import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nocvla/utils/my_audios.dart';

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
  void onInit() {
    super.onInit();
    _initAudio();
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

  Future<void> playMusic() async {
    final state = _player.state;
    if (state != PlayerState.playing && state != PlayerState.paused) {
      await _initAudio();
    }
  }

  void changeMenuSelected({required int idx}) => currentIndex.value = idx;
}
